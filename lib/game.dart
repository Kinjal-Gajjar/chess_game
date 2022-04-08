import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BoardColor tcolor = BoardColor.brown;
  ChessBoardController chessBoardController = ChessBoardController();
  @override
  Widget build(BuildContext context) {
    setState(() {
      tcolor = tcolor;
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chess"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Board Theme',
                  ),
                  value: tcolor,
                  items: const [
                    DropdownMenuItem(
                      child: Text("Brown"),
                      value: BoardColor.brown,
                    ),
                    DropdownMenuItem(
                      child: Text("Dark Brown"),
                      value: BoardColor.darkBrown,
                    ),
                    DropdownMenuItem(
                        child: Text("Green"), value: BoardColor.green),
                    DropdownMenuItem(
                        child: Text("Orange"), value: BoardColor.orange)
                  ],
                  onChanged: (BoardColor? value) {
                    tcolor = value!;
                    setState(() {
                      tcolor;
                    });
                  }),
            ),
            ChessBoard(
              controller: chessBoardController,
              size: MediaQuery.of(context).size.width,
              enableUserMoves: true,
              boardColor: tcolor,
            ),
            Expanded(
              child: ValueListenableBuilder<Chess>(
                valueListenable: chessBoardController,
                builder: (context, game, _) {
                  return Text(
                    chessBoardController.getSan().fold(
                          '',
                          (previousValue, element) =>
                              previousValue + '\n' + (element ?? ''),
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                setState(() {
                  chessBoardController.game.reset();
                })
              },
          mini: true,
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.undo_rounded)),
    );
  }
}
