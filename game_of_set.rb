# Ridiculous 6
# CSE 3901
# Project 2

# Numbers: 1, 2, 3
# Colors: Green, Blue, Red
# Shapes: Diamond, Tilde, Oval
# Opacity: Transparent, Translucent, Opaque
class Card
  attr_accessor :number, :color, :shape, :opacity

  # This function defines the initializer for a card. A card has 4 qualities:
  # Number of symbols, Color of symbols, shape of symbols, and opacity of symbols.
  def initialize(number, color, shape, opacity)
    @number = number
    @color = color
    @shape = shape
    @opacity = opacity
  end

  # Defines a compare function for the cards, to see if two are identical or not, without requiring
  # them to be identical in memory.
  def compare(card)
    same = false
    if @number != card.number && @color != card.color && @shape != card.shape && @opacity != card.opacity
      same = true
      puts 'Unique'
    else
      puts 'Not Unique'
    end
    same
  end

  # define the string format of a card
  def to_s
    "#{@number}, #{@color}, #{@shape}, #{@opacity}"
  end
end

# This function creates and returns a standard Set deck of 81 unique cards.
def create_deck
  # parameter options are defined as arrays of the 3 possible options for each of the
  # 4 parameters
  nums = %w[1 2 3]
  colors = %w[Green Blue Red]
  shapes = %w[Diamond Tilde Oval]
  opacities = %w[Transparent Shaded Filled]
  deck = []
  # cards are created with a 4 layer nested loop, for each possible parameter combination, and no more.
  (0..2).each do |a|
    num = nums[a]
    (0..2).each do |b|
      color = colors[b]
      (0..2).each do |c|
        shape = shapes[c]
        (0..2).each do |d|
          opacity = opacities[d]
          # create a new card with the current parameters and add it to the deck
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
  # First if checks if either all numbers are the same or all numbers are different.
  ans = if !((card1.number == card2.number) && (card2.number == card3.number) ||
    (card1.number != card2.number) && (card1.number != card3.number) && (card2.number != card3.number))
  then  false
    # second if checks if either all shapes are the same or all shapes are different.
        elsif !((card1.shape == card2.shape) && (card2.shape == card3.shape) ||
          (card1.shape != card2.shape) && (card1.shape != card3.shape) && (card2.shape != card3.shape))
        then false
        # third if checks if either all opacities are the same or all opacities are different.
        elsif !((card1.opacity == card2.opacity) && (card2.opacity == card3.opacity) ||
          (card1.opacity != card2.opacity) && (card1.opacity != card3.opacity) && (card2.opacity != card3.opacity))
        then false
        # last if checks if either all colors are the same or all colors are different.
        elsif !((card1.color == card2.color) && (card2.color == card3.color) ||
          (card1.color != card2.color) && (card1.color != card3.color) && (card2.color != card3.color))
        then false
        # last if checks to make sure the cards aren't just the same card chosen 3 times.
        elsif card1 == card2 || card2 == card3 || card1 == card3
        then false
        # if none of the above ifs have flagged as false, then the set is valid.
        else
          true
        end
end

# checks the current deal to make sure there is at least one set present.
# @param deal the current deal of cards
# @return a boolean that states whether or not a set is present
def check_for_sets(deal)
  set_present = false
  # create an array of all possible 3 card combinations.
  all_combinations = deal.combination(3).to_a
  i = 0
  # this loop checks through the above array, checking each combination to see whether or not it's a set
  # it continues until it either has checked all combinations without finding a set, or it finds a combination.
  until set_present || (i == all_combinations.size - 1)
    set_present = true if check_set(all_combinations[i][0], all_combinations[i][1], all_combinations[i][2])
    i += 1
  end
  set_present
end

# this function gets the user number of the person inputting a guess, it first checks if this is a valid set, then
# either gives them a point or tells them that their set is invalid.
# @param user_num: the user_num who's guessing (for this game mode, should always be 0)
# @param deal: the current deal of cards
# @param deck: the current deck of non-dealt cards, only present for update_hand_on_set
# @param scores: the array of scores
def get_player_guess(user_num, deal, deck, scores)
  # prompt the user for the cards they think make up a set
  puts "Alright, player number #{user_num}, enter the 3 cards you think are part of the set on 3 separate lines."
  card1 = deal[gets.to_i]
  card2 = deal[gets.to_i]
  card3 = deal[gets.to_i]
  # check if their set is valid. if it is, update score and the deal/deck.
  is_valid_set = check_set(card1, card2, card3)
  if is_valid_set
    puts "Good job! That's one point for you!\n\n"
    scores[user_num] += 1
    update_hand_on_set(deal, deck, card1, card2, card3)
    # if their set isn't valid, tell them and do nothing.
  else
    puts "Oof! I'm afraid that's not a valid set! Better luck next time.\n"
  end
end

# This function updates the deal and the deck in the case that a valid set has been input
# @param deal: the current deal
# @param deck: the current non-dealt deck
# @param card1: the 1st card
# @param card2: the 2nd card
# @param card3 the 3rd card
def update_hand_on_set(deal, deck, card1, card2, card3)
  # create a clone to replace the deal
  new_deal = deal.clone
  # delete the set's cards from the deal
  new_deal.delete(card1)
  new_deal.delete(card2)
  new_deal.delete(card3)
  # only deal more cards if the deck isn't empty
  unless deck.empty?
    # add 3 more cards and take those cards out of the deck.
    new_deal.concat(deck[0, 3])
    new_deck = deck.slice(3..deck.length)
    deck.replace(new_deck)
  end
  # replace the old deal with the updated one
  deal.replace(new_deal)
end


# welcome the player to the game, get the number of players
puts 'Welcome to the game of set!'
puts 'You can have up to 4 players. How many would you like to have? (enter a number 1-4)'
# loop gathers an acceptable player count, and will run until they enter a valid count.
acceptable_player_count = false
until acceptable_player_count
  player_count = gets
  pc = player_count.to_i
  if pc.positive? && pc < 5
    acceptable_player_count = true
  else
    puts 'That\'s not an acceptable number of players! Please try again with a number between 1 and 4.'
  end
end
puts 'Okay, everyone gets a user number. Decide this now, and when you see a set, type in your number so you get credit for the set!'
puts "(As a note: Player numbers start at 1, not zero, for purposes of assigning user numbers)\n\n"
# initialize scores array to 0 for all players.
scores = Array.new(pc)
i = 0
while i < pc
  scores[i] = 0
  i += 1
end

# set up the deck and deal the first hand
deck = create_deck
deck = deck.shuffle
deal = deck[0, 12]
deck = deck.slice(12..81)
set_present = check_for_sets(deal)
# game will loop until the deck is empty and there are no more sets in the current deal.
until deck.empty? && !set_present
  i = 0
  puts 'Here\'s the deal!'
  while i < deal.size
    puts "#{i}: #{deal[i]}"
    i += 1
  end
  set_present = check_for_sets(deal)
  # if there are no sets in the current deal, deal 3 more cards.
  if !set_present
    if !deck.empty?
      puts 'Oops! That deal didn\'t have any sets! let\'s get a few more cards on the board and try that again!'
      deal.concat(deck[0, 3])
      dl = deck.length
      deck = deck.slice(3, dl)
    else
      # if there are no sets and the deck is empty, the game is over.
      break
    end
  else
    # prompt the players for their user number - the first user to see a set types their number
    puts 'Alright! If you see a set, type your user number in, then type the numbers of the cards in the set you see.'
    user_num = gets.to_i
    if user_num < 0 || user_num > (pc - 1)
      puts 'That\'s not a valid player number! Try again with a valid player number.'
    else
      get_player_guess(user_num, deal, deck, scores)
    end
  end
end
# at the end of the game, output the score table.
puts 'Game Over! The scores are as follows:'
i = 0
while i < pc
  puts "Player #{i}: #{scores[i]}"
  i += 1
end

