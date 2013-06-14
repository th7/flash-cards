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
    @game = Game.new
    @deck = @game.current_deck(0)
    start
  end

  def start
    puts "Welcome to Ruby Flash Cards. To play, just enter the correct term for each definition.  Ready?  Go!"
    loop do
      show_main_menu
      user_choice = gets.chomp
      if user_choice == '1'
        begin_game
      elsif user_choice == '2'
        @deck.shuffle!
      elsif user_choice == '3'
        show_decks
        index = gets.chomp.to_i-1
        @deck = @game.current_deck(index)
      elsif user_choice == '4'
        goodbye_message
        exit
      end
    end
  end

  def show_main_menu
    puts "What would you like to do?"
    puts "1-Begin Game, 2-Shuffle, 3-Select Deck, 4-Exit"
  end

  def show_decks
    counter = 1
    puts "Please select a deck."
    @game.deck_names.each do |name|
      puts "#{counter} - name"
      counter += 1
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
