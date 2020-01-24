import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';

import 'MyHomePage.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  AudioCache audioPlayer = AudioCache(prefix: 'audio/');

  TextEditingController playerOneController;
  TextEditingController playerTwoController;

  String player1;
  String player2;

  @override
  void initState()
  {
    this.playerOneController = TextEditingController();
    this.playerTwoController = TextEditingController();

    this.player1 = "Player 1";
    this.player2 = "Player 2";

    super.initState();
  }

  void dispose() {
    this.playerOneController.dispose();
    this.playerTwoController.dispose();

    super.dispose();
  }

  void startGame()
  {
    this.audioPlayer.play('press_but.mp3');

    String playerOneName = playerOneController.text.trim();
    String playerTwoName = playerTwoController.text.trim();

    if (playerOneName.isNotEmpty)
    {
      setState(() {
        this.player1 = playerOneName;
      });
    }

    if (playerTwoName.isNotEmpty)
    {
      setState(() {
        this.player2 = playerTwoName;
      });
    }

    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (BuildContext context) => MyHomePage(this.player1, this.player2)
      )
    );
  }

  Widget playerInput(controller, labelText, iconData) => 
  Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[

      // player icon color selection start
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Image(
            height: 32,
            width: 32,
            image: AssetImage('assets/$iconData'),
          ),
        ),
      ),
      // player icon color selection end

      // player name input start
      Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 10),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: labelText,
            ),
          ),
        ),
      )
      // player name input end

    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[

                // game logo & name start
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 32),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Image(
                            height: 80,
                            width: 80,
                            image: AssetImage('assets/circle.png'),
                          ),

                          Image(
                            height: 80,
                            width: 80,
                            image: AssetImage('assets/cross.png'),
                          ),

                        ],
                      ),

                      Container(height: 8),

                      Text(
                        "tic tac toe",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          color: Color(0xFF00BF72),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                // game logo & name end

                Container(height: 16),

                // player info start
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[

                      playerInput(
                        playerOneController,
                        "Player 1",
                        'cross.png',
                      ),

                      Container(height: 16),

                      playerInput(
                        playerTwoController,
                        "Player 2",
                        'circle.png',
                      ),

                    ],
                  ),
                ),
                // player info end

                // start game button start
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: RaisedButton(
                    padding: EdgeInsets.all(16),
                    color: Color(0xFF00BF72),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      "Start Game",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: startGame,
                  ),
                ),
                // start game button end

              ],
            ),
          ),
        ),
      ),
    );
  }
}