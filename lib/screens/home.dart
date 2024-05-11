import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _focusModeEnabled = false;
  Duration _sessionDuration = Duration(hours: 1);
  Duration _remainingTime = Duration(hours: 1);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggleFocusMode() {
    setState(() {
      _focusModeEnabled = !_focusModeEnabled;
      if (_focusModeEnabled) {
        _startTimer();
      } else {
        _remainingTime = Duration(hours: 0);
      }
    });
  }

  void _startTimer() {
    _remainingTime = _sessionDuration;
    Future.delayed(Duration(seconds: 1), () {
      if (_focusModeEnabled) {
        setState(() {
          _remainingTime -= Duration(seconds: 1);
        });
        _startTimer();
      }
    });
  }

  String _formatTime(Duration duration) {
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Focus Mode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _focusModeEnabled ? 'Focus Mode Enabled' : 'Focus Mode Disabled',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Current Session: ${_sessionDuration.inHours} hours',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Remaining Time: ${_formatTime(_remainingTime)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleFocusMode,
              child: Text(
                  _focusModeEnabled ? 'End Focus Mode' : 'Start Focus Mode'),
            ),
          ],
        ),
      ),
    );
  }
}
