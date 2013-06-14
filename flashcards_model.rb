#require_relative 'flashcard_controller'

class Game
  attr_reader :deck_names
  
  def initialize
    @deck_names = ["flashcard_samples.txt", "tristans_deck.txt", "karsts_deck.txt", "tylers_deck.txt", "pats_deck.txt"]
  end

  def current_deck(index)
    fill_deck_from_file(@deck_names[index])
  end

  def fill_deck_from_file(filename)
    raw_flashcards = text_from_file(filename)
    create_cards_from(filename, raw_flashcards)
  end

  def text_from_file(filename)
    File.readlines(filename).reject { |line| line.strip.empty? }
  end
  
  def create_cards_from(filename, raw_flashcards)
    deck = Deck.new(filename)
    raw_flashcards.each_slice(2) do |card|
      deck.take_in(Flashcard.new(card))
    end
    deck
  end

  def print_deck
    puts @current_deck
  end
end

class Deck
  attr_reader :filename

  def initialize(filename)
    @deck = []
    @filename = filename
  end

  def take_in(card)
    deck << card
  end

  def shuffle!
    deck.shuffle!
  end
  
  def next_question!
    advance_card!
    this_card.question if this_card
  end
  
  def correct?(answer)
    if answer == this_card.answer
      if this_card.retry
        this_card.retry = false
        return true
      else
        @deck.pop
        return true
      end
    else
      this_card.retry = true
      return false
    end
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
  attr_accessor :retry
  attr_reader :answer, :question  
  
  def initialize(card)
    @question = card[0].chomp#gsub("\n", "")
    @answer = card[1].chomp
    @retry = false
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









class DeadCode
# DEAD CODE
    # sorting_queue = []
    # fill_sorting_queue!(filename, sorting_queue)
    # delete_blanks!(sorting_queue)
    # create_cards(sorting_queue)
    # remove_blanks_from(raw_flashcards)
    # temporary_store.fill!(filename)
    # temporary_store.delete_blanks!
    # create_cards_from(temporary_store)
  # def fill_sorting_queue!(filename, sorting_queue)
  #   File.open(filename).each_line do |line|
  #     sorting_queue << line
  #   end
  # end
  # def delete_blanks!(sorting_queue)
  #   sorting_queue.delete_if{ |cell| cell == " \n" }
  # end
    # until sorting_queue.count == 0
    #   card = sorting_queue.shift(2)
    #   @current_deck.take_in(Flashcard.new(card))
    # end
  # attr_accessor :deck
  # def to_s
  #   puts @deck
  # end
end
