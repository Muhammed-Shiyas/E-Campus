import 'package:flutter/material.dart';

class intro_page2 extends StatelessWidget {
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
                  image: AssetImage('assets/learn.png'),
                ),
                SizedBox(height: 80),
                Text(
                  'Chat with your Teacher',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Education breeds confidence. Confidence breeds hope. Hope breeds peace -Confucius',
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
