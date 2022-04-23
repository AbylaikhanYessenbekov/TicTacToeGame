class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static const boardLength = 9;
  static const blocSize = 100.0;

  List<String>? board;
  static List<String>? initGameBoard() {
    return List.generate(boardLength, (index) => Player.empty);
  }

  bool winnerCheck(String player, int index, List<int> scoreBoard, int gridSize) {
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 : -1;

    scoreBoard[row] += score;
    scoreBoard[gridSize + col] += score;
    if(row == col) {
      scoreBoard[gridSize * 2] += score;
    }
    if(gridSize - 1 - col == row) {
      scoreBoard[gridSize * 2 + 1] += score;
    }

    if(scoreBoard.contains(3) || scoreBoard.contains(-3)) {
      return true;
    }


    return false;
  }
}