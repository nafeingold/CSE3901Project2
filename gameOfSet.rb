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

# checks the current deal to make sure there is at least one set present.
# @param deal the current deal of cards
def check_for_sets(deal)
  set_present = false
  all_combinations = deal.combination(3).to_a
  i = 0
  until set_present || (i == all_combinations.size - 1)
    set_present = true if check_set(all_combinations[i][0], all_combinations[i][1], all_combinations[i][2])
    i += 1
  end
  set_present
end


# welcome the player to the game, get the number of players
puts 'Welcome to the game of set!'
puts 'You can have up to 4 players. How many would you like to have? (enter a number 1-4)'
acceptable_player_count = false
until acceptable_player_count
  player_count = gets
  pc = player_count.to_i
  if pc > 0 && pc < 5
    acceptable_player_count = true
  else
    puts 'That\'s not an acceptable number of players! Please try again with a number between 1 and 4.'
  end
end
scores = Array.new(pc)

# set up the deck and deal the first hand
deck = create_deck
deck = deck.shuffle
deal = deck[0, 12]
deck = deck.slice(12..81)
puts 'First hand, coming up!'
puts deal



puts check_for_sets(deal)


