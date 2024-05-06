import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socks5_proxy/socks_server.dart';

class Server {
  static SocksServer? socksServer;
  static Future<void> createSocksServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var server = Server.socksServer;
    if (server == null) {
      server = SocksServer();
      Server.socksServer = server;
    }

    // Listen to all tcp and udp connections
    server!.connections.listen((connection) async {
      // Uint8List rawBytes;
      print("Host: ${connection.desiredAddress.host}");
      await connection.forward();
    }).onError(print);

    // Bind servers
    server!.bind(InternetAddress.loopbackIPv4, 1080);
    server!.bind(InternetAddress.loopbackIPv6, 1080);
    print("Socks5 proxy server started on port 1080");
  }

  static closeSocksServer() {}
}
