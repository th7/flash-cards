#require_relative 'flashcard_controller'

class FlashcardModel
  attr_accessor :current_deck
  
  def initialize
    sorting_queue = []
    @current_deck = Deck.new
    File.open("flashcard_samples.txt").each_line do |line|
      sorting_queue << line
    end
    sorting_queue.delete_if{ |cell| cell == " \n" }
    until sorting_queue.count == 0
      card = sorting_queue.shift(2)
      @current_deck.take_in(Flashcard.new(card))  
    end
  end
  
  def print_deck
    puts @current_deck
  end
end

class Deck
  attr_accessor :deck
  
  def initialize
    @deck = []
  end

  def take_in(card)
    @deck << card
  end

  def to_s
    puts @deck
  end

  def shuffle!
    deck.shuffle!
  end
  
  def next_question!
    card = deck.shift
    deck << card
  end
  
  def correct?(answer)
    answer == @deck.first.answer
  end
  
  def get_answer
    @deck.first.answer 
  end

end

class Flashcard
  attr_reader :answer, :question  
  
  def initialize(card)
    @answer = card[1].gsub("\n", "") 
    @question = card[0].gsub("\n", "")
  end

  def to_s
    "#{@question} 
    #{@answer}"
  end
end

bob = FlashcardModel.new

# bob.current_deck.to_s
# bob.current_deck.next_question!
#print bob.current_deck.get_answer
