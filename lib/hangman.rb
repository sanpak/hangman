class Hangman
  attr_reader :guesser, :referee, :board
  def initialize(players)
    # puts "__________guesser________________"
    @guesser =  players[:guesser]
    @referee = players[:referee]
    @board = board
  end

  def take_turn

    # puts "what's your guess?"
    # player_guess = gets.chomp
    @guesser.guess
    setup
    update_board
    @guesser.handle_response
  end

  def setup
    @referee.pick_secret_word
    @guesser.register_secret_length(@referee.pick_secret_word)
    @board = Array.new(@referee.pick_secret_word)
    @referee.check_guess(@guesser.guess)
  end

  def update_board
    @board
  end

end

class HumanPlayer
end

class ComputerPlayer
  attr_accessor :secret_word, :dictionary, :secret_word, :candidate_words
  def initialize(dictionary)
    @dictionary = dictionary
    @secret_word = dictionary[rand(dictionary.length)]
    # @secret_word = contents[rand(contents.length)].chomp
  end

  def pick_secret_word
    @secret_word.length
  end

  def check_guess(letter)
    result = []
    @secret_word.chars.each_with_index do |secret_letter,idx|
      result << idx if secret_letter == letter
    end
    result
  end

  def check_word(word,letter)
    pos_array = []
    word.chars.each_with_index do |alphabet,idx|
      pos_array << idx if alphabet == letter
    end
    return pos_array
  end

  def guess(board)
    # board.length
    #  player.register_secret_length(6)
  end

  def register_secret_length(length)
    #don't need to do anything?
    puts "The length of the secret word is #{length}"
    @candidate_words = @dictionary.select { |word| word.length == pick_secret_word }
  end

  def handle_response(letter,idx)
    candidate_words.select! { |word| check_word(word,letter) == idx }
  end


end
