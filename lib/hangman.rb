class Hangman
  attr_reader :guesser, :referee, :board
  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @board = board
  end

  def setup
    length = @referee.pick_secret_word
    @guesser.register_secret_length(length)
  end

  def board
    length = @referee.pick_secret_word
    @board = Array.new(length)
    # puts "Secret word: #{@board}"
  end

end

class HumanPlayer




end

class ComputerPlayer

  def initialize(dictionary)
    @dictionary = dictionary
    @secret_word = @dictionary.sample
  end

  def pick_secret_word
    @secret_word.length
  end

  def check_guess(letter)
    found_letters_idx = []
    @secret_word.chars.each_with_index do |el,idx|
      found_letters_idx << idx if el == letter
    end
    found_letters_idx
  end

  def register_secret_length(length)
    @length = length
  end

end
