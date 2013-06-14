#require_relative 'flashcard_controller'

class Game
  attr_accessor :current_deck
  
  def initialize
    @current_deck = Deck.new
    fill_deck_from_file("flashcard_samples.txt")
  end

  def fill_deck_from_file(filename)
    # sorting_queue = []
    # fill_sorting_queue!(filename, sorting_queue)
    # delete_blanks!(sorting_queue)
    # create_cards(sorting_queue)

    raw_flashcards = text_from_file(filename)
    # remove_blanks_from(raw_flashcards)
    create_cards_from(raw_flashcards)

    # temporary_store.fill!(filename)
    # temporary_store.delete_blanks!
    # create_cards_from(temporary_store)
    
  end

  def text_from_file(filename)
    File.readlines(filename).reject { |line| line.strip.empty? }
  end
  
  # def fill_sorting_queue!(filename, sorting_queue)
  #   File.open(filename).each_line do |line|
  #     sorting_queue << line
  #   end
  # end

  # def delete_blanks!(sorting_queue)
  #   sorting_queue.delete_if{ |cell| cell == " \n" }
  # end

  def create_cards_from(raw_flashcards)
    raw_flashcards.each_slice(2) do |card|
      @current_deck.take_in(Flashcard.new(card))
    end

    # until sorting_queue.count == 0
    #   card = sorting_queue.shift(2)
    #   @current_deck.take_in(Flashcard.new(card))
    # end
  end

  def print_deck
    puts @current_deck
  end
end

class Deck
  # attr_accessor :deck
  
  def initialize
    @deck = []
  end

  def take_in(card)
    deck << card
  end

  # def to_s
  #   puts @deck
  # end

  def shuffle!
    deck.shuffle!
  end
  
  def next_question!
    advance_card!
    this_card.question
  end
  
  def correct?(answer)
    answer == this_card.answer
  end
  
  def get_answer
    this_card.answer 
  end

  def this_card
    deck.last
  end

  def advance_card!
    card = deck.shift
    deck << card
  end

  private

  attr_reader :deck

end

class Flashcard
  attr_reader :answer, :question  
  
  def initialize(card)
    @question = card[0].chomp#gsub("\n", "")
    @answer = card[1].chomp
  end

  def to_s
    "#{question} 
    #{answer}"
  end
end

# bob = FlashcardModel.new

# bob.current_deck.to_s
# bob.current_deck.next_question!
#print bob.current_deck.get_answer
