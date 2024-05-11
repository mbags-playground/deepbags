import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/lost_astronaut.png', // Replace with your asset path
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Houston, we have a problem...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Looks like you found a lost corner of space.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Take me back to safety'),
            ),
          ],
        ),
      ),
    );
  }
}
