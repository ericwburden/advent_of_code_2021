# Helper Functions -------------------------------------------------------------

byte2bits(byte)   = digits(byte, base=2, pad=8)
bytes2bits(bytes) = BitVector(mapreduce(byte2bits, vcat, reverse(bytes)))
const hex2bits = bytes2bits ∘ hex2bytes
const read2bits = hex2bits ∘ readchomp


# Ingest the Data -------------------------------------------------------------

function ingest(path)
    return read2bits(path)
end

