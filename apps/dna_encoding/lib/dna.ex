defmodule DNA do
  @spec encode_nucleotide(charlist()) :: non_neg_integer()
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  @spec decode_nucleotide(non_neg_integer()) :: charlist()
  def decode_nucleotide(encoded_code) do
    case encoded_code do
       0b0000 -> ?\s
       0b0001 -> ?A 
       0b0010 -> ?C 
       0b0100 -> ?G 
       0b1000 -> ?T     
    end
  end

  @spec encode(charlist()) :: bitstring()
  def encode(dna) do
    do_encode(dna, <<>>)
  end
  defp do_encode([], acc), do: acc
  defp do_encode([nucleotide | rest], acc) do 
    do_encode(rest, <<acc::bitstring, encode_nucleotide(nucleotide)::size(4)>>)
  end

  @spec decode(bitstring()) :: charlist()
  def decode(dna) do
    do_decode(dna, [])
  end
  defp do_decode(<<>>, acc), do: Enum.reverse(acc)
  defp do_decode(<<nucleotide::4, rest::bitstring>>, acc) do
    do_decode(rest, [decode_nucleotide(nucleotide) | acc])
  end
end
