# frozen_string_literal: true

# Just enough image parsing to answer three questions about a committed file:
# how wide it is, and whether it still carries the metadata a phone put in it.
#
# Hand-rolled rather than pulled from a gem because the questions are narrow
# and the answers must not depend on a dependency resolving. A format this does
# not understand is reported as unknown and fails the check that uses it, which
# is the safe direction: a new format should be a deliberate decision, not a
# silent pass.
class ImageFile
  ROOT = File.expand_path("../..", __dir__)

  # The JPEG frame markers that carry dimensions. C4 is a Huffman table, C8 is
  # reserved and CC is an arithmetic-coding table — same range, different
  # meaning, and reading dimensions out of one gives nonsense.
  START_OF_FRAME = ((0xC0..0xCF).to_a - [0xC4, 0xC8, 0xCC]).freeze

  attr_reader :path

  def initialize(path)
    @path = path
    @bytes = File.binread(path)
  end

  # What a failure message calls this file: the path a contributor can open.
  def name
    path.sub("#{ROOT}/", "")
  end

  def bytes
    @bytes.bytesize
  end

  def format
    return :jpeg if @bytes.start_with?("\xFF\xD8".b)
    return :png  if @bytes.start_with?("\x89PNG\r\n\x1A\n".b)
    return :gif  if @bytes.start_with?("GIF87a".b) || @bytes.start_with?("GIF89a".b)
    return :svg  if @bytes.lstrip.start_with?("<?xml", "<svg")

    :unknown
  end

  # [width, height], or nil when the format is not one this understands.
  def dimensions
    case format
    when :jpeg then jpeg_dimensions
    when :png  then [read32(16), read32(20)]
    when :gif  then [read16le(6), read16le(8)]
    end
  end

  def width
    dimensions&.first
  end

  # Any EXIF block at all. A processed image has none: the tooling that resizes
  # a photo for the web strips the block whole rather than editing it, so the
  # presence of one means the file went up as it came off the phone.
  def exif?
    case format
    when :jpeg then jpeg_segments.any? { |marker, body| marker == 0xE1 && body.start_with?("Exif\x00\x00".b) }
    when :png  then png_chunks.include?("eXIf")
    else false
    end
  end

  # Whether that EXIF block carries a GPS IFD — the tag that turns a photo of
  # dinner into a published home address.
  def gps?
    return false unless exif?

    exif = case format
           when :jpeg then jpeg_segments.find { |marker, body| marker == 0xE1 && body.start_with?("Exif\x00\x00".b) }&.last&.byteslice(6..)
           when :png  then png_chunk_data("eXIf")
           end
    return false if exif.nil? || exif.bytesize < 8

    little = exif.start_with?("II".b)
    offset = unpack(exif, 4, 4, little)
    return false if offset.nil? || offset + 2 > exif.bytesize

    count = unpack(exif, offset, 2, little)
    (0...count).any? do |i|
      entry = offset + 2 + (i * 12)
      unpack(exif, entry, 2, little) == 0x8825 # GPSInfo IFD pointer
    end
  end

  private

  def read32(at)
    @bytes.byteslice(at, 4)&.unpack1("N")
  end

  def read16le(at)
    @bytes.byteslice(at, 2)&.unpack1("v")
  end

  def unpack(data, at, size, little)
    slice = data.byteslice(at, size)
    return nil if slice.nil? || slice.bytesize < size

    slice.unpack1(size == 2 ? (little ? "v" : "n") : (little ? "V" : "N"))
  end

  # [[marker, body], ...] up to the start of the compressed data, which is
  # where the metadata stops and the picture begins.
  def jpeg_segments
    @jpeg_segments ||= begin
      segments = []
      at = 2
      while at + 4 <= @bytes.bytesize && @bytes.getbyte(at) == 0xFF
        marker = @bytes.getbyte(at + 1)
        break if marker == 0xDA || marker == 0xD9 # start of scan, end of image

        length = @bytes.byteslice(at + 2, 2).unpack1("n")
        break if length.nil? || length < 2

        segments << [marker, @bytes.byteslice(at + 4, length - 2).to_s]
        at += 2 + length
      end
      segments
    end
  end

  def jpeg_dimensions
    at = 2
    while at + 4 <= @bytes.bytesize && @bytes.getbyte(at) == 0xFF
      marker = @bytes.getbyte(at + 1)
      length = @bytes.byteslice(at + 2, 2).unpack1("n")
      break if length.nil? || length < 2
      if START_OF_FRAME.include?(marker)
        return [@bytes.byteslice(at + 7, 2).unpack1("n"), @bytes.byteslice(at + 5, 2).unpack1("n")]
      end
      break if marker == 0xDA

      at += 2 + length
    end
    nil
  end

  def png_chunks
    @png_chunks ||= png_walk.map(&:first)
  end

  def png_chunk_data(type)
    png_walk.find { |name, _| name == type }&.last
  end

  def png_walk
    @png_walk ||= begin
      chunks = []
      at = 8
      while at + 8 <= @bytes.bytesize
        length = @bytes.byteslice(at, 4).unpack1("N")
        type = @bytes.byteslice(at + 4, 4)
        break if length.nil? || type.nil?

        chunks << [type, @bytes.byteslice(at + 8, length).to_s]
        break if type == "IEND"

        at += 12 + length
      end
      chunks
    end
  end
end
