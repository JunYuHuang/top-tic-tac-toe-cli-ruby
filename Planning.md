# Planning Notes

## MVP Requirements

- allows 2 players to place X and O pieces on a 3 x 3 grid / board
- displays / prints the board as string in console output between turns:
  - before any piece has been placed
  - any time the board is updated with a new placed piece
  - a player places their piece on an invalid position so the game prompts them to select another position on the board
  - after the last turn that results in a victory for one player or tie for both players

## Game Logic

- while game is not over
  - check if game is over
    - if game is over
      - get game results
        - winner: X, O, or none (tie)
    - else continue
  - determine which player's turn it is
    - if no players have gone yet
      - it is X's turn
    - else turn is for player who did not go last
  - get coordinates of cell / position on board to place piece from player
  - while input position is invalid,
    - do not update board or progress
    - get coordinates of cell / position on board to place piece from player
  - place player's game piece (X or O) on board
  - update data structure that notes which player went last

## UI Logic

- while game is not over
  - display current board
  - while the player's input is invalid
    - if the player whose turn it is previously inputted an invalid input this turn, display a message that tells them their previously request position was invalid
    - display which player's turn it is
    - display how to format the valid input
    - get player input for cell they want to place their piece on
- display game result

## Expanded Game Logic Functions / Classes / Data Structures

- `Piece` class
  - class / static variables
    - :cross
    - :circle
    - :empty
  - public methods
    - getters for :cross, :circle, and :empty

- `Board` class
  - private / protected methods
  - public methods
    - constructor(grid, size = 3)
      - initialises instance variables
        - `size`: integer representing the number of cells in each side of the board
        - `grid`: 2D array / matrix of dimensions `size` * `size` where each cell holds a `Piece` key
        - `pieces_placed`: integer set to 0 that counts how many non-empty pieces have been placed on the board
    - place(row, col, piece)
      - sets instance.`grid[row][col]` to piece
      - increments `pieces_placed` by 1
    - isPlaceable(row, col)?
      - returns boolean that checks if a piece can be placed @ self.`grid[row][col]`
      - if row or col are not integers, return false
      - if row or col are not in bounds of the grid, return false
      - returns true if cell is empty else false
    - meetsMinWinCondition()?
      - return self.`pieces_placed` >= `size` * 2 - 1
    - didPieceWin(piece)?
      - returns boolean that determines if the player `piece` won or not
      - for every row in self.`grid`,
        - if there are self.`size` occurrences of `piece`, return true
      - for every col in self.`grid`,
        - if there are self.`size` occurrences of `piece`, return true
      - for the positive (bot-left to top-right) diagonal in self.`grid`,
        - if there are self.`size` occurrences of `piece`, return true
      - for the negative (top-left to bot-right) diagonal in self.`grid`,
        - if there are self.`size` occurrences of `piece`, return true
      - return false
    - isFull()?
      - returns true if every cell in self.`grid` is a non-empty piece
      - return `pieces_placed` == self.`size` * self.`size`

- `State` class
  - instance / variables
  - public methods
    - constructor(board, starting_piece = `Piece.cross`)
      - `board`: object instance of `Board` class
      - `turn`: static / class variable of `Piece` class equal to `Piece.cross` or `Piece.circle`, set initially to `Piece.cross`
    - isGameOver()?:
      - returns boolean that indicates if the game is over or not
      - if not self.`board.meetsMinWinCondition()?`, return false
      - if self.`board.didPieceWin(Piece.cross)?`, return true
      - if self.`board.didPieceWin(Piece.circle)?`, return true
      - return self.`board.isFull()?`
    - getters
      - `turn`
      - `board`
    - setBoard(row, col):
      - returns boolean and potentionally updates self.`board`
      - if not self.`board.isPlaceable()?`, return false
      - self.`board.place(row, col, turn)`
      - return true
    - setTurn():
      - sets the next turn
      - if self.`turn` was `Piece.cross`,
        - update self.`turn` to `Piece.circle`
      - else, update self.`turn` to `Piece.cross`
    - getWinner()
      - if !isGameOver(), return `nil`
      - if `board.didPieceWin?(Piece.cross)`,
        - return `Piece.cross`
      - else if `board.didPieceWin(Piece.circle)`,
        - return `Piece.circle`
      - else game was tie, return `Piece.empty`

- `ConsoleDisplay` class
  - clears the console / terminal before each turn
  - renders the game board as a multi-line string with ASCII characters
    - 3 x 3 board with
      - visual gutter space separators
      - empty space piece(s)
      - `X` piece(s)
      - `O` piece(s)
      - row and column 0 to 2 numbered index headers that line up with the board visually
  - renders which player's turn it is as a single line string
    - e.g. `It is player X's turn.`
  - renders instructions for how to place a valid position on the board for the player as a multiline string
    - `A valid position or cell is in the format "row,col".`
    - `E.g. 1,1 is the top-left corner cell of the board and`
    - `would be valid if there is no X or O piece occupying it`
    - `Enter a valid position to place your piece on the board:`

## UI Design

### Boards

```
  1 2 3
1
2
3
```

```
  1 2 3
1   O X
2 X X X
3 O   O
```

```
  1 2 3
1 X O X
2 X O O
3 O X X
```
