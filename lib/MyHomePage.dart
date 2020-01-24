import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audio_cache.dart';

class MyHomePage extends StatefulWidget {

  final String player1;
  final String player2;

  MyHomePage(this.player1, this.player2);

  @override
  _MyHomePageState createState() => _MyHomePageState(this.player1, this.player2);
}

class _MyHomePageState extends State<MyHomePage> {

  AudioCache audioPlayer = AudioCache(prefix: 'audio/');

  String player1;
  String player2;

  List gameState;

  bool isGameOver;
  bool isCross = true;
  String message;

  _MyHomePageState(this.player1, this.player2);

  @override
  initState()
  {
    setState(() {
      gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];

      isGameOver = false;
    });

    super.initState();
  }

  void resetGame()
  {
    this.audioPlayer.play('press_but.mp3');

    setState(() {
      gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];

      message = "";
      isGameOver = false;
    });
  }
  
  void onPressGrid(int index) 
  {
    if (this.gameState[index] == "empty" && !isGameOver) 
    {
      setState(() {
        this.gameState[index] = isCross? "cross" : "circle";
        this.isCross = !this.isCross;
      });

      this.audioPlayer.play('place_mark.mp3');
      checkWin();
    }
  }

  void checkWin()
  {
    // check row
    if (
      this.gameState[0] != "empty" &&
      this.gameState[0] == this.gameState[1] &&
      this.gameState[1] == this.gameState[2]
    ) 
    {
      setState(() {
        isGameOver = true;
        message = this.gameState[0];
      });

      this.audioPlayer.play('win.mp3');
      
    }
    else if (
      this.gameState[3] != "empty" &&
      this.gameState[3] == this.gameState[4] &&
      this.gameState[4] == this.gameState[5]
    )
    {
      setState(() {
        isGameOver = true;
        message = this.gameState[3];
      });

      this.audioPlayer.play('win.mp3');
    }
    else if (
      this.gameState[6] != "empty" &&
      this.gameState[6] == this.gameState[7] &&
      this.gameState[7] == this.gameState[8]
    )
    {
      setState(() {
        isGameOver = true;
        message = this.gameState[6];
      });

      this.audioPlayer.play('win.mp3');
    }
    // check Column
    else if (
      this.gameState[0] != "empty" &&
      this.gameState[0] == this.gameState[3] &&
      this.gameState[3] == this.gameState[6]
    )
    {
      setState(() {
        isGameOver = true;
        message = this.gameState[0];
      });

      this.audioPlayer.play('win.mp3');
    }
    else if (
      this.gameState[1] != "empty" &&
      this.gameState[1] == this.gameState[4] &&
      this.gameState[4] == this.gameState[7]
    )
    {
      setState(() {
        isGameOver = true;
        message = this.gameState[1];
      });

      this.audioPlayer.play('win.mp3');
    }
    else if (
      this.gameState[2] != "empty" &&
      this.gameState[2] == this.gameState[5] &&
      this.gameState[5] == this.gameState[8]
    )
    {
      setState(() {
        isGameOver = true;
        message = this.gameState[2];
      });

      this.audioPlayer.play('win.mp3');
    }
    // left diagonal
    else if (
      this.gameState[0] != "empty" &&
      this.gameState[0] == this.gameState[4] &&
      this.gameState[4] == this.gameState[8]
    )
    {
      setState(() {
        isGameOver = true;
        message = this.gameState[0];
      });

      this.audioPlayer.play('win.mp3');
    }
    else if (
      this.gameState[2] != "empty" &&
      this.gameState[2] == this.gameState[4] &&
      this.gameState[4] == this.gameState[6]
    )
    {
      setState(() {
        isGameOver = true;
        message = this.gameState[2];
      });

      this.audioPlayer.play('win.mp3');
    }
    else if (
      !this.gameState.contains("empty")
    )
    {
      setState(() {
        isGameOver = true;
        message = "Its Draw";
      });

      this.audioPlayer.play('gameover.mp3');
    }

    if (message.isNotEmpty) {
      showWin();
    }
  }

  AssetImage getIcon(String state) 
  {
    switch (state) 
    {
      case "empty": return AssetImage('assets/edit.png');
      case "cross": return AssetImage('assets/cross.png');
      case "circle": return AssetImage('assets/circle.png');
    }
  }

  Future<void> showWin() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Game over', 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                // player icon start
                Container(
                  alignment: Alignment.center,
                  child: getIcon(message) != null? 
                    Column(
                      children: <Widget>[

                        Image(
                          height: 75,
                          width: 75,
                          image: getIcon(message),
                        ),

                        Container(height: 10),

                        Text(
                          message == "cross" ? "$player1 winner!" : "$player2 winner!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ) : 
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ),
                // player icon end

              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Quit Game'),
              onPressed: () {
                Navigator.of(context).pop();
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),

            FlatButton(
              child: Text('Restart Game'),
              onPressed: () {
                this.resetGame();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget playerLogo(iconData, bool isMyTurn) => 
  Card(
    elevation: isMyTurn? 1 : 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: isMyTurn? 
        BorderSide(width: 5, color: Colors.green.shade400) : 
        BorderSide(width: 0, color: Colors.transparent),
    ),
    child: Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(8),
      child: Image(
        image: AssetImage('assets/$iconData'),
      ),
    )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
        backgroundColor: Color(0xFF00BF72),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[

            // players logo start
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  playerLogo(
                    'cross.png',
                    this.isCross,
                  ),

                  playerLogo(
                    'circle.png',
                    !this.isCross
                  ),

                ],
              ),
            ),
            // players logo end

            Container(height: 10),

            // game board start
            Expanded(
              child: GridView.builder(
                itemCount: gameState.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ), 
                itemBuilder: (BuildContext context, int index) 
                { 
                  return Card(
                    elevation: this.gameState[index] == "empty"? 5 : 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: this.gameState[index] == "empty"? 
                        BorderSide(width: 5, color: Color(0xFF00BF72)) : 
                        BorderSide(width: 0, color: Colors.transparent), 
                    ),
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Image(
                          height: 14,
                          width: 14,
                          image: getIcon(this.gameState[index]),
                          fit: BoxFit.contain,
                        ),
                      ),
                      onTap: () => onPressGrid(index),
                    ),
                  );
                },
              ),
            ),
            // game board end

            // restart game button start
            Container(
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 20),
                color: Color(0xFF00BF72),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Text(
                  "Restart Game",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: resetGame,
              ),
            ),
            // restart game button end

          ],
        ),
      ),
    );
  }
}