class Writer
  ALPHABET = {
    "a" => ["0.", "..", ".."],
    "b" => ["0.", "0.", ".."],
    "c" => ["00", "..", ".."],
    "d" => ["00", ".0", ".."],
    "e" => ["0.", ".0", ".."],
    "f" => ["00", "0.", ".."],
    "g" => ["00", "00", ".."],
    "h" => ["0.", "00", ".."],
    "i" => [".0", "0.", ".."],
    "j" => [".0", "00", ".."],
    "k" => ["0.", "..", "0."],
    "l" => ["0.", "0.", "0."],
    "m" => ["00", "..", "0."],
    "n" => ["00", ".0", "0."],
    "o" => ["0.", ".0", "0."],
    "p" => ["00", "0.", "0."],
    "q" => ["00", "00", "0."],
    "r" => ["0.", "00", "0."],
    "s" => [".0", "0.", "0."],
    "t" => [".0", "00", "0."],
    "u" => ["0.", "..", "00"],
    "v" => ["0.", "0.", "00"],
    "w" => [".0", "00", ".0"],
    "x" => ["00", "..", "00"],
    "y" => ["00", ".0", "00"],
    "z" => ["0.", ".0", "00"],
    "!" => ["..", "00", "0."],
    "\'" => ["..", "..", "0."],
    "," => ["..", "0.", ".."],
    "-" => ["..", "..", "00"],
    "." => ["..", "00", ".0"],
    "?" => ["..", "0.", "00"],
    "shift" => ["..", "..", ".0"],
    "space" => ["  ", "  ", "  "],
    "#" => [".0", ".0", "00"],
  }

  def convert(string)
    array_of_eighty_point_words = score_and_shovel(string)
    array_of_eighty_point_words.map { |string| convert_letters(string) }.flatten
  end

  private

  def score_and_shovel(string)
    score, starting_index, key_index, scored_strings = 0, 0, 0, []
    string.chars.each_with_index do |letter, index|
      add_score = check_letter_case(letter)
      if (score += add_score) > 80
        score = 0
        key_index = (index - 1)
        scored_strings << string[starting_index..key_index]
        starting_index = index
      end
    end
    scored_strings << string[starting_index..-1]
  end

  def check_letter_case(letter)
    letter == letter.upcase ? 4 : 2
  end

  def convert_letters(string)
    converted_letters = string.chars.reduce([]) do |collector, letter|
      collector << ALPHABET["space"] if letter == " "
      collector << ALPHABET["shift"] if letter == letter.upcase
      collector << ALPHABET[letter.downcase] unless !ALPHABET[letter.downcase]
      collector
    end
    combine_arrays(converted_letters)
  end

  def combine_arrays(array_of_individual_letters)
    solution = [[], [], []]
    array_of_individual_letters.each do |array|
      solution[0] << array[0]
      solution[1] << array[1]
      solution[2] << array[2]
    end
    join_lines(solution)
  end

  def join_lines(array_of_arrays)
    array_of_arrays.map do |array|
      array.join
    end
  end
end
