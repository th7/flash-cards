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

#   def shuffle
#   end

# end



class FlashcardController

  def initialize
    @deck = FlashcardModel.new
    start
  end

  def main_menu
    loop do
      puts "What would you like to do?"
      puts "1-Begin Game, 2-Shuffle, 3-Quit"
      input = gets.chomp.to_i
      case input
      when 1
        begin_game
      when 2
        @deck.shuffle!
      when 3
        exit
      end
    end
  end

  def begin_game
    puts "Press enter blank answer to exit game."
    while ask_question(@deck.next_question)
    end    
  end

  def ask_question(question)
    incorrect_counter = 0

    loop do 
      puts question
      guess = gets.chomp
      if @deck.correct?(question, guess)
        puts "Correct!"
        return true
      elsif guess == ""
        return false
      else
        incorrect_counter += 1
        if incorrect_counter > 2
          puts "Incorrect. View answer? y/n"
          input = gets.chomp
          next if input == "n"
          puts @deck.get_answer(question)
        else
          puts "Incorrect. Guess again."
        end
        next
      end
    end
  end

  def start
    puts "Welcome to Ruby Flash Cards. To play, just enter the correct term for each definition.  Ready?  Go!"
    main_menu
  end

end

FlashcardController.new
