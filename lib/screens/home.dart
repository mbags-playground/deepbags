import 'dart:isolate';

import 'package:deepbags/server.dart';
import 'package:deepbags/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isActive = false;
  ReceivePort? serverProcessPort;
  static Server? server;

  toggleSwitch(bool value) {
    if (_isActive == false) {
      setState(() {
        _isActive = true;
      });
      startBackgroundTask();
    } else {
      stopBackgroundTask();
      setState(() {
        _isActive = false;
      });
    }
  }

  void startBackgroundTask() async {
    ReceivePort port = ReceivePort();
    setState(() {
      serverProcessPort = port;
    });
    var result = await Isolate.spawn(_backgroundTask, port.sendPort);
    port.listen((message) {
      if (message == "exit") {
        Server.server?.close();
        if (result.terminateCapability != null) {
          result.kill(priority: Isolate.immediate);
        }
      }
    });
  }

  void stopBackgroundTask() async {
    print(serverProcessPort.toString());
    if (serverProcessPort != null) serverProcessPort!.sendPort.send("exit");
  }

  static void _backgroundTask(SendPort sendPort) async {
    server = Server();
    await server!.createServer();
    sendPort.send('Task completed successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: GradientText(
          text: "Deepbags",
          gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 29, 39, 29),
            Colors.blue.shade700,
          ]),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GradientText(
              text: "Deepbags",
              gradient: LinearGradient(colors: [
                Colors.green.shade300,
                Colors.blue.shade700,
              ]),
              style:
                  const TextStyle(fontSize: 38.0, fontWeight: FontWeight.w900),
            ),
          ),
          Switch(value: _isActive, onChanged: toggleSwitch),
          Text(_isActive ? "Active" : "Inactive")
        ],
      ),
    );
  }
}
