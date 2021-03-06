require "./hash"

module SSZ
  BYTES_PER_CHUNK         = 32 # Number of bytes per chunk.
  BYTES_PER_LENGTH_OFFSET =  4 # Number of bytes per serialized length offset.
  BITS_PER_BYTE           =  8 # Number of bits per byte.

  {% if BYTES_PER_LENGTH_OFFSET == 4 %}
  alias Offset = Int32
  {% elsif BYTES_PER_LENGTH_OFFSET == 2 %}
  alias Offset = Int16
  {% elsif BYTES_PER_LENGTH_OFFSET == 1 %}
  alias Offset = Int8
  {% end %}

  EMPTY_CHUNK = Bytes.new(BYTES_PER_CHUNK, 0_u8)

  NUM_ZERO_HASHES = 100
  ZERO_HASHES = make_zero_hashes

  private def self.make_zero_hashes : Array(Bytes)
    zero_hashes = Array(Bytes).new(size: NUM_ZERO_HASHES, value: Bytes.empty)
    zero_hashes.map_with_index! do |_, i|
      if i == 0
        EMPTY_CHUNK
      else
        SSZ.hash(zero_hashes[i - 1] + zero_hashes[i - 1])
      end
    end
    zero_hashes
  end
end
