## Chess
Chess for the console, with a focus on computer AI.

### Setup
Clone or download zip.
To play a regular game load the Game.rb file (e.g.ruby game.rb).
To run a comparison of the 2 computer AI's load the game\_test.rb file with a command line arg for how many test games should be played (e.g.ruby game_test.rb 10).

### Features
A regular [game](game.rb) let's you choose any combination of computer and human players (white computer will be the stronger AI, black the weaker). The Game class is designed as an api that allows both types of players to interface with it.

The [human player](players/human_player.rb) inputs his moves using proper chess co-ords (e.g e2, e4) which are then converted into the array co-ords

The [computer player](players/computer_player.rb) uses a custom made AI to compete.

A special game mode, [game_test](game_test.rb) especially created for comparing computer ai. It plays the amount of games specified in the first ARGV, and outputs the result totals. (Games have a capped length (75 moves) in this mode to ensure results are produced in a reasonable time)

The [Piece](pieces/piece.rb) class uses polymorphic methods and inheritance with Slideable and Stepable inherritting from Piece and the individual types of pieces inheritting from them in turn.

### Computer AI
The better AI gives a score to each possible move accounting for piece mobility and pieces captured, minus the score of opponents best response. 
For mobility extra weight is given to the central squares with less weight given to the side columns.
Piece values are updated in their respective classes based on game situation. (Currently only implemented for Pawns in last 2 row, with others planned).

### Rules not yet implemented
en passent and castling
board position repeats 3 times, and 50 move rule (no capture or pawn moved).

### TODO
Create a number of AI strengths and let the player choose the computer difficulty.

