import 'package:flutter/material.dart';

import 'colors.dart';
import 'game_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = 'X';
  bool gameOver = false;
  int turn = 0; // to check if it's draw
  String result = "";
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0]; // Scoreboard to check winner

  // Instantiating game object
  Game game = Game();
  // Initializing game in initState() at the beginning of the app
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's $lastValue turn".toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 58.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardLength ~/ 3,
              padding: const EdgeInsets.all(16.0),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardLength, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          if (game.board![index] == "") {
                            //condition allows us to tap only on empty blocks
                            setState(() {
                              game.board![index] =
                                  lastValue; //sets a value to blocks
                              turn++;
                              gameOver = game.winnerCheck(lastValue, index, scoreBoard, 3);
                              if(gameOver) {
                                result = 'Winner is $lastValue';
                              }
                              if (lastValue == "X") {
                                //condition to toggle player
                                lastValue = "O";
                              } else {
                                lastValue = "X";
                              }
                            });
                          }
                        },
                  child: Container(
                    width: Game.blocSize,
                    height: Game.blocSize,
                    decoration: BoxDecoration(
                      color: MainColor.secondaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                          color: game.board![index] == 'X'
                              ? Colors.blue
                              : Colors.pink,
                          fontSize: 64.0,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 25.0,),
          Text(result, style: const TextStyle(color: Colors.white),),
          IconButton(
            onPressed: () {
              //Resetting all values on the board
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                scoreBoard = [0,0,0,0,0,0,0,0,0,];
              });
            },
            icon: const Icon(Icons.replay),
            iconSize: 35.0,
            color: MainColor.accentColor,
          )
        ],
      ),
    );
  }
}
