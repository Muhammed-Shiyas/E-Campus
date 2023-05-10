import 'package:flutter/material.dart';

class intro_page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/aichatbot.png'),
                ),
                SizedBox(height: 80),
                Text(
                  'AI Chat Bot ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'clear your doubts using AI',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
