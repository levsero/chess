## Chess
Chess for the console, with a focus on computer AI.

### Setup
Clone or download zip.

To play a regular game load the Game.rb file in the console ($ruby game.rb).

To run a comparison of the 2 computer AI's load the game\_test.rb file with a command line arg for how many test games should be played ($ruby game_test.rb 10).

### Features
A regular [game](game.rb) let's you choose any combination of computer and human players (white computer will be the stronger AI, black the weaker). The Game class is designed as an api that allows both types of players to interface with it.

The [human player](players/human_player.rb) inputs his moves using proper chess co-ords (e.g e2, e4) which are then converted into the array co-ords

The [computer player](players/computer_player.rb) uses a custom made AI to compete.

A special game mode, [game_test](game_test.rb) especially created for comparing computer AIs. It plays the number of games specified in the first ARGV, and outputs the result totals. (Games have a capped length (75 moves) in this mode to ensure results are produced in a reasonable time)

The [Piece](pieces/piece.rb) class uses polymorphic methods and inheritance with Slideable and Stepable inherritting from Piece and the individual types of pieces inheritting from them in turn.

### Computer AI
Contains two seperate computer players, one with a more basic AI which is used for testing against the second more powerful AI. 

The AI allocates a score to each possible move accounting for piece mobility and pieces captured, minus the score of opponents best response. Chooses the move with the highest score.

For mobility extra weight is given to the central squares with less weight given to the side columns.

Pawns are given a higher value when they near the end of the other side.

### Rules not yet implemented
en passant and castling

draw when board position repeats 3 times, and 50 move rule (no capture or pawn moved).

### TODO
Create a number of AI strengths and let the player easily choose the computer difficulty.

Refactor AI classes to allow arguments to be passed in to toggle which parts of the rating algorithm are used.

