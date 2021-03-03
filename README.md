# game_of_set and game_of_set_with_computer_player

These two files implement the game of set. The first is for local multiplayer, and the latter
is for local single-player against an AI. They are played through the command line. The program
prints the cards currently dealt, and asks the user to find a set. This is where the two programs
diverge.

# game_of_set

For game of set, any of the users can enter their user number, and then enter a set. Assuming
they correctly identified a set, the cards are removed from the deal and the deal and deck are
updated. This continues with all users finding sets until the deck is empty, and there are no
more sets in the deal. At this point, the game is over and the scoreboard is shown.

# game_of_set_with_computer_player

For the computer version of the game, the user has a semi-random amount of time, based on the
difficulty they chose, to find a set and enter their user number. If they do, the game follows the
same structure as above. If they don't find a set in time, the computer finds a set and goes instead.
This again continues until the deck is empty and there are no more sets in the deal, at which point
the game prints the scoreboard.

@author: Noah Feingold, The Ridiculous 6
@date 1 March 2021
