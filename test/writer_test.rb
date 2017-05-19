require './test/test_helper'
require './lib/writer'

class WriterTest < Minitest::Test
  def test_it_is_a_thing
    write = Writer.new
    assert_instance_of(Writer, write)
  end

  def test_can_convert_single_letter_to_array_of_braille
    writer = Writer.new
    assert_equal(["0.", "..", ".."], writer.convert("a"))
  end

  def test_can_convert_and_return_two_letters
    write = Writer.new
    assert_equal(["0.0.", "..0.", "...."], write.convert("ab"))
  end

  def test_can_convert_uppercase_letters
    write = Writer.new
    assert_equal(["..0.", "....", ".0.."], write.convert("A"))
  end

  def test_can_convert_two_uppercase_letters
    write = Writer.new
    assert_equal(["..0...0.", "..0.....", ".0...0.."], write.convert("BA"))
  end

  def test_can_convert_one_uppercase_and_one_lowercase
    write = Writer.new
    assert_equal(["..0.0.", "..0...", ".0...."], write.convert("Ba"))
  end

  def test_constrains_to_80_characters
    write = Writer.new
    actual_string = "a" * 40 + "z"
    assert_equal(41, actual_string.length)
    assert_equal(actual_string, actual_string.downcase)
    expected = ["0." * 40, ".." * 40, ".." * 40, "0.", ".0", "00"]
    assert_equal(expected, write.convert(actual_string))
  end

  def test_constrains_to_80_characters_from_78_to_82_points
    write = Writer.new
    actual_string = "a" * 39 + "A"
    assert_equal(40, actual_string.length)
    expected = ["0." * 39, ".." * 39, ".." * 39, "..0.", "....", ".0.."]
    assert_equal(expected, write.convert(actual_string))
  end
end
