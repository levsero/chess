## Chess

Chess borught to life in the console, with a focus on computer AI.

### Setup
Clone or download zip.
To play a regular game load the Game.rb file.
To run a comparison of the 2 computer AI's load the game_test.rb file.

### Features
A regular [game](game.rb) let's you choose any combination of computer and human players.

The [human player](players/human_player.rb) inputs his moves using proper chess co-ords (e.g e2, e4) which are then converted into the array co-ords

The [computer player](players/computer_player.rb) uses a custom made AI to compete.

A special game mode, [game_test](game_test.rb) especially created for comparing computer ai.

### Computer AI
The AI currently accounts for piece mobility, pieces captured and the opponents best response. In mobility more weight is given to the central squares with less weight given to the side columns.
