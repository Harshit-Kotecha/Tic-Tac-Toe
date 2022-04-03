import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayExOh = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  bool ohTurn = true; //o is first
  int ohScore = 0, exScore = 0;
  int filledBox = 0;
  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);

  // add avatar glow learning from playlist
  
  static var myNewFontWhite = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white, letterSpacing: 3),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player X ',
                        style: myNewFontWhite,
                      ),
                      Text(
                        exScore.toString(),
                        style: myNewFontWhite,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player O ',
                        style: myNewFontWhite,
                      ),
                      Text(
                        ohScore.toString(),
                        style: myNewFontWhite,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        displayExOh[index],
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: Container(
                child: Column(
                  children: [
                    Text('Tic Tac Toe', style: myNewFontWhite),
                  ],
                )
          )),
        ],
      ),
    );
  }

// we change state in tapped function and call checkWinner and showDialogBox and they update values so setState update them again.
  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'o';
        filledBox++;
      } else if (!ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'x';
        filledBox++;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayExOh[0] != '' &&
        displayExOh[0] == displayExOh[1] &&
        displayExOh[1] == displayExOh[2]) {
      _showWinDialog(displayExOh[1]);
    }
    if (displayExOh[3] != '' &&
        displayExOh[3] == displayExOh[4] &&
        displayExOh[4] == displayExOh[5]) {
      _showWinDialog(displayExOh[5]);
    }
    if (displayExOh[6] != '' &&
        displayExOh[6] == displayExOh[7] &&
        displayExOh[7] == displayExOh[8]) {
      _showWinDialog(displayExOh[7]);
    }
    if (displayExOh[0] != '' &&
        displayExOh[0] == displayExOh[4] &&
        displayExOh[4] == displayExOh[8]) {
      _showWinDialog(displayExOh[2]);
    }
    if (displayExOh[2] != '' &&
        displayExOh[2] == displayExOh[4] &&
        displayExOh[4] == displayExOh[6]) {
      _showWinDialog(displayExOh[4]);
    }
    if (displayExOh[0] != '' &&
        displayExOh[0] == displayExOh[3] &&
        displayExOh[3] == displayExOh[6]) {
      _showWinDialog(displayExOh[3]);
    }
    if (displayExOh[1] != '' &&
        displayExOh[1] == displayExOh[4] &&
        displayExOh[4] == displayExOh[7]) {
      _showWinDialog(displayExOh[1]);
    }
    if (displayExOh[2] != '' &&
        displayExOh[2] == displayExOh[5] &&
        displayExOh[5] == displayExOh[8]) {
      _showWinDialog(displayExOh[2]);
    }

    if (filledBox == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('DRAW'),
          actions: [
            TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context)
                      .pop(); //to pop off the clear board dialog box
                },
                child: Text('Play Again!')),
          ],
        );
      },
    );
  }

  void _showWinDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('WINNER IS : ' + winner),
          actions: [
            TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context)
                      .pop(); //to pop off the clear board dialog box
                },
                child: Text('Play Again!')),
          ],
        );
      },
    );
    if (winner == 'o') {
      ohScore++;
    } else if (winner == 'x') {
      exScore++;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExOh[i] = '';
      }
    });
    filledBox = 0;
  }
}
