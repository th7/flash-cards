require_relative 'flashcards_model'

# class FlashcardModel

#   def initialize
#   end

#   def correct?(question, guess)
#     guess == "2"
#   end

#   def next_question
#     "What's 1+1?"
#   end

#   def get_answer(question)
#     "2"
#   end

#   def shuffle!
#   end

# end



class FlashcardController

  def initialize
    @deck = FlashcardModel.new.current_deck
    start
  end

  def start
    puts "Welcome to Ruby Flash Cards. To play, just enter the correct term for each definition.  Ready?  Go!"
    main_menu
  end

  def main_menu
    loop do
      puts "What would you like to do?"
      puts "1-Begin Game, 2-Shuffle, 3-Exit"
      input = gets.chomp
      case input
      when '1'
        begin_game
      when '2'
        @deck.shuffle!
      when '3'
        exit
      when 'exit'
        exit
      end
    end
  end

  def begin_game
    puts "Answer 'exit' to exit game."
    while ask_question(@deck.next_question!); end
  end

  def ask_question(question)
    tries = 0

    loop do 
      puts question
      guess = gets.chomp
      if @deck.correct?(guess)
        puts "Correct!"
        return true
      elsif guess.downcase == "exit"
        return false
      else
        tries += 1   
        handle_incorrect(question, tries)
      end
    end
  end

  def handle_incorrect(question, tries)
    if tries > 2
      puts "Incorrect. View answer? y/n"
      input = gets.chomp
      if input == "y"
        puts "The correct answer is: #{@deck.get_answer}"
      end
    else
      puts "Incorrect. Guess again."
    end
  end

end

FlashcardController.new
