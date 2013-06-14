#require_relative 'flashcard_controller'

class FlashcardModel

  def initialize
    sorting_queue = []
    current_deck = Deck.new
    File.open("flashcard_samples.txt").each_line do |line|
      sorting_queue << line
    end
    sorting_queue.delete_if{ |cell| cell == " \n" }
    until sorting_queue.count == 0
      card = sorting_queue.shift(2)
      puts Flashcard.new(card)
   #   current_deck << Flashcard.new(card)
    end
  end
end

class Deck
  def initialize
  end
end

class Flashcard
  def initialize(card)
    @answer = card[1].gsub("\n", "") 
    @question = card[0].gsub("\n", "")
  end

  def to_s
    "
    #{@question} 
    #{@answer}
    "
  end
end

bob = FlashcardModel.new

