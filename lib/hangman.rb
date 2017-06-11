class Hangman
  attr_reader :guesser, :referee, :board
  def initialize(players)
    # puts "__________guesser________________"
    @guesser =  players[:guesser]
    @referee = players[:referee]
    @board = board
  end

  def take_turn
    puts "_________take_turn____________"
    # puts "what's your guess?"
    # player_guess = gets.chomp
    @guesser.guess
    setup
    update_board
    @guesser.handle_response
  end

  def setup
    puts "__________setup_____________"
    p @referee.pick_secret_word
    p @guesser.register_secret_length(@referee.pick_secret_word)
    p @board = Array.new(@referee.pick_secret_word)
    p @referee.check_guess(@guesser.guess)
  end

  def update_board
    puts "_______________update_board____________"
    p @board
  end

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

  def check_guess(letter)
    result = []
    @secret_word.chars.each_with_index do |secret_letter,idx|
      result << idx if secret_letter == letter
    end
    result
  end

  def guess(board)
    # puts "________letter__________"
    p board[1]
    #  player.register_secret_length(6)
  end

  def candidate_words
    puts "_________________candidate_WORDS___________"
    candidate_words = []
    candidate_words << self.secret_word
    p candidate_words
  end

  def register_secret_length(length)


  end

  def handle_response(letter,array)
  end


end
