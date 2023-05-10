import 'package:flutter/material.dart';

class intro_page1 extends StatelessWidget {
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
                  image: AssetImage('assets/ebook.png'),
                ),
                SizedBox(height: 180),
                Text(
                  'E-librray',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'If you don’t like to read, you haven’t found the right book.-J.K. Rowling',
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
