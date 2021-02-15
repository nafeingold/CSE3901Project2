# Rediculous 6
# CSE 3901
# Project 2

# Numbers: 1, 2, 3
# Colors: Green, Blue, Red
# Shapes: Diamond, Tilde, Oval
# Opacity: Transparent, Translucent, Opaque

class Card
  attr_accessor :number, :color, :shape, :opacity

  def initialize(number, color, shape, opacity)
    @number = number
    @color = color
    @shape = shape
    @opacity = opacity
  end

  def compare(card)
    if @number != card.number && @color != card.color && @shape != card.shape && @opacity != card.opacity
      puts 'Unique'
    else
      puts 'Not Unique'
    end
  end

  def to_s
    "#{@number}, #{@color}, #{@shape}, #{@opacity}"
  end
end

def create_deck
  nums = %w[1 2 3]
  colors = %w[Green Blue Red]
  shapes = %w[Diamond Tilde Oval]
  opacities = %w[Transparent Shaded Filled]
  deck = []
  (0..2).each do |a|
    num = nums[a]
    (0..2).each do |b|
      color = colors[b]
      (0..2).each do |c|
        shape = shapes[c]
        (0..2).each do |d|
          opacity = opacities[d]
          c = Card.new(num, color, shape, opacity)
          deck.append(c)
        end
      end
    end
  end
  deck
end

##
# checks if a set is valid or not
# @param card1 the first card
# @param card2 the second card
# @param card3 the third card
# @return boolean is or is not a set
##
def check_set(card1, card2, card3)
  ans = if !((card1.number == card2.number) && (card2.number == card3.number) ||
      (card1.number != card2.number) && (card1.number != card3.number) && (card2.number != card3.number))
      then  false
        elsif !((card1.shape == card2.shape) && (card2.shape == card3.shape) ||
      (card1.shape != card2.shape) && (card1.shape != card3.shape) && (card2.shape != card3.shape))
      then false
        elsif !((card1.opacity == card2.opacity) && (card2.opacity == card3.opacity) ||
      (card1.opacity != card2.opacity) && (card1.opacity != card3.opacity) && (card2.opacity != card3.opacity))
      then false
        elsif !((card1.color == card2.color) && (card2.color == card3.color) ||
        (card1.color != card2.color) && (card1.color != card3.color) && (card2.color != card3.color))
    then false
        else
          true
        end
end



# c1 = Card.new('1', 'Green', 'Diamond', 'Transparent')
# c2 = Card.new('2', 'Blue', 'Tilde', 'Shaded')
# c3 = Card.new('3', 'Red', 'Oval', 'Filled')
# puts(check_set(c1, c2, c3))

deck = create_deck
deck = deck.shuffle
deal = deck[0,11]
deck.slice(0..11)
puts deal

