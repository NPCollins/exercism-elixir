defmodule PaintByNumber do
  @spec palette_bit_size(non_neg_integer(), non_neg_integer()) :: non_neg_integer()
  def palette_bit_size(color_count, pow \\ 1) do
    if (Integer.pow(2, pow) >= color_count) do
      pow
    else
      palette_bit_size(color_count, pow + 1)
    end
  end

  @spec empty_picture() :: bitstring()
  def empty_picture() do
    <<>>
  end

  @spec test_picture() :: bitstring()
  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  @spec prepend_pixel(bitstring(), non_neg_integer(), non_neg_integer()) :: bitstring()
  def prepend_pixel(picture, color_count, pixel_color_index) do
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  @spec get_first_pixel(bitstring(), non_neg_integer()) :: non_neg_integer() | nil
  def get_first_pixel(picture, color_count)
  def get_first_pixel(<<>>, _), do: nil
  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<value::size(bit_size), _::bitstring>> = picture
    value
  end

  @spec drop_first_pixel(bitstring(), non_neg_integer()) :: bitstring()
  def drop_first_pixel(picture, color_count)
  def drop_first_pixel(<<>>, _), do: <<>>
  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<_::size(bit_size), rest::bitstring>> = picture
    rest
  end

  @spec concat_pictures(bitstring(), bitstring()) :: bitstring()
  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
