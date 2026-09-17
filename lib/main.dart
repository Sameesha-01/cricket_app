import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const CricketApp());
}

class CricketApp extends StatelessWidget {
  const CricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Cricket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF063A75))
        useMaterial3: true,
      ),
      home: const MiniCricketScreen(),
    );
  }
}

class CricketScreen extends StatelessWidget {
  const CricketScreen({super.key});

  @override
  State<MiniCricketScreen> createState() => _MiniCricketScreenState();
}

class _MiniCricketScreenState extends State<MiniCricketScreen> {
  int runs = 0;
  int balls = 6;
  String resultText = "";
  final Random _random = Random();

  // Possible runs per ball in Mini Cricket: 0 (No Runs), 1, 2, 3, 4, 6
  final List<int> _possibleRuns = [0, 1, 2, 3, 4, 6];

  void _onButtonPressed() {
    if (balls > 0) {
      // Hit a ball
      int scored = _possibleRuns[_random.nextInt(_possibleRuns.length)];
      setState(() {
        balls--;
        runs += scored;
        if (scored == 0) {
          resultText = "No Runs";
        } else if (scored == 1) {
          resultText = "1 Run";
        } else {
          resultText = "$scored Runs";
        }
      });
    } else {
      // Over finished -> Restart game
      setState(() {
        runs = 0;
        balls = 6;
        resultText ="";
      });
    }
  } 

  @override
  Widget build(BuildContext context) {
    bool isOver = balls == 0;

    return Scaffold(
      backgroundColor: const Color(0xFF1976D2),
      appBar: AppBar(
        title: const Text(
          'Mini Cricket',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,

          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF063A75),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child:Center(
                          child: Container(
                            width: 140,
                            height: 140,
                            color: Colors.white,
                            padding: const EdgeInsets.all(4),
                            child: Image.asset(
                              'assets/images/bat.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: 140,
                            height: 140,
                            color: Colors.white,
                            padding: const EdgeInsets.all(4),
                            child: Image.asset(
                              'assets/images/ball.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Runs',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Balls',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          '$runs',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '$balls',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                SizedBox(
                  height: 32,
                  child: Center(
                    child: Text(
                      resultText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isOver
                        ? const Color(0xFFB71C1C)
                        : const Color(0xFF0D47A1),
                    foregroundColor: Colors.white,
                    elevation:4,
                    padding: const EdgeInsets.symmetric(horizontal:26, vertical:10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    isOver ? 'Restart' : 'Bat',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                
              ]
            ),
          ),
        ),
        
      ),
    );
  }
}
