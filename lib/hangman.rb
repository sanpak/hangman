class Hangman
  attr_reader :guesser, :referee, :board
end

class HumanPlayer
end

class ComputerPlayer
  attr_accessor :secret_word
  def initialize(dictionary)
    @secret_word = dictionary[rand(dictionary.length)]
    p @secret_word
    # @secret_word = contents[rand(contents.length)].chomp
  end

  def pick_secret_word
    @secret_word.length
  end
end
