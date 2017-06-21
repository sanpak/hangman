require 'byebug'

class Hangman
  attr_reader :guesser, :referee, :board
  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
    @board = board
  end

  def board
    @board
    # @board = Array.new(length)
    # puts "Secret word: #{@board}"
  end

  def setup
    length = @referee.pick_secret_word
    @guesser.register_secret_length(length)
    @board = Array.new(length)
  end

  def take_turn
    # debugger
    @guess = @guesser.guess(@board)
    @check_result = @referee.check_guess(@guess)
    update_board
    @guesser.handle_response(@guess,@check_result)
  end

  def play
    setup
    print "Secret_word: "
    until over?
      print "> "
      take_turn
    end
    puts "Secret word was #{@board.join}"
  end
  #
  def over?
    return true if @board.all? { |el| el != nil }
    return false
  end

  private

  def update_board
    @check_result.each do |idx|
      @board[idx] = @guess
    end
  end

  def print_board
    board_display = ""
    @board.each do |el|
      board_display << (el.nil? ? "_" : el)
    end
    board_display
  end

end

class HumanPlayer
  attr_accessor :guess
  def initialize
    # @guess = guess
    #don't need this so it go straight to the game.
    #no exra enter
  end

  def register_secret_length(length)
  end

  def guess(board)
    board_display = ""
    board.each do |el|
      board_display << (el.nil? ? "_" : el)
    end
    puts "#{board_display}"
    gets.chomp
  end

  # def register_secret_length(length)
  #   length
  # end

  def handle_response(guess,check_guess)
  end

  def pick_secret_word
    puts "Think of a secret word"
    gets.chomp.to_i
  end

  def check_guess(letter)
    puts "The computer has guessed the letter: #{letter}"
    puts "what position: ex.1,2. Press Enter if there is no match."
    found_letters_idx = gets.chomp.split(",").map { |el| el.to_i - 1 }

    # found_letters_idx = []
    # @secret_word.chars.each_with_index do |el,idx|
    #   found_letters_idx << idx if el == letter
    # end
    # found_letters_idx
  end


end

class ComputerPlayer
  attr_accessor :candidate_words
  def self.dictionary
    contents = File.readlines("dictionary.txt")
    @secret_word = contents.sample.chomp
  end

  def initialize(dictionary)
    #following two lines make this pass the r spec
    # @dictionary = dictionary
    # @secret_word = @dictionary.sample

    #the following make this game playable
    #make this game playable
    @dictionary = File.readlines(dictionary)
    @dictionary = @dictionary.map { |word| word.chomp }
    # @secret_word = @dictionary.sample
    contents = File.readlines(dictionary)
    @secret_word = contents.sample.chomp
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
     @candidate_words = @dictionary.select { |word| word.length == @length }
  end

  def guess(board)
    # debugger
    ("a".."z").to_a.sample
    joined_word = @candidate_words.join
    counter = 0
    most_common_letter = ""
    joined_word.chars.each do |el|
      if joined_word.count(el) > counter && board.include?(el) == false
        counter = joined_word.count(el)
        most_common_letter = el
      end
    end
    most_common_letter
  end

  def check_word(word,letter)
    idx_array = []
    word.chars.each_with_index do |el,idx|
      idx_array << idx if el == letter
    end
    idx_array
  end

  def handle_response(guess_letter,positions)
    @candidate_words.reject! do |word|
      pos_idx = []
      word.chars.each_with_index do |el,idx|
        pos_idx << idx if el == guess_letter
      end
      pos_idx != positions
    end
    # puts "__________handle response_____________"
    @candidate_words
  end


end


if __FILE__ == $PROGRAM_NAME
  puts "Do you want to be a guesser or referee? (g/r)"
  ans = gets.chomp.downcase
  if ans == "g"
    players = {
      referee: ComputerPlayer.new("dictionary.txt"),
      guesser: HumanPlayer.new
    }
  elsif ans == "r"
    players = {
      guesser: ComputerPlayer.new("dictionary.txt"),
      referee: HumanPlayer.new
    }
  else
    puts "invalid input"
  end

  game = Hangman.new(players)

  game.play
end
