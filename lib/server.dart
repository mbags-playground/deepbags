import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:socks5_proxy/socks_server.dart';

class Server {
  static HttpServer? server;
  Server();

  Future<HttpServer> createServer() async {
    final address = InternetAddress.loopbackIPv4;
    const port = 4040;
    final server = await HttpServer.bind(address, port);
    print('Server started: ${server.address} port ${server.port}');
    createSocksServer();
    await for (HttpRequest request in server) {
      handleRequest(request);
    }

    return server;
  }

  void handleRequest(HttpRequest request) async {
    final destinationUrl = request.uri;
    if (destinationUrl.host == "") {
      request.response.statusCode = 404;
      request.response.write("Served from deepbags");
      await request.response.close();
      return;
    }
    final client = HttpClient();
    print("request received${request.method} ${request.uri.toString()}");
    final proxyRequest = await client.openUrl(request.method, destinationUrl);

    // Copy headers from the original request to the proxy request
    request.headers.forEach((name, value) {
      proxyRequest.headers.set(name, value);
    });

    final proxyResponse = await proxyRequest.close();

    // Copy the response status code and headers back to the original response
    request.response.statusCode = proxyResponse.statusCode;
    proxyResponse.headers.forEach((name, value) {
      request.response.headers.set(name, value);
    });

    // Copy the response body (if any) back to the original response
    await proxyResponse.pipe(request.response);

    // Close the response
    await request.response.close();
  }

  void createSocksServer() {
    final proxy = SocksServer();

    // Listen to all tcp and udp connections
    proxy.connections.listen((connection) async {
      // Uint8List rawBytes;
      print("Host:${connection.desiredAddress.host}");

      await connection.forward();
    }).onError(print);

    // Bind servers
    proxy.bind(InternetAddress.loopbackIPv4, 1080);
    proxy.bind(InternetAddress.loopbackIPv6, 1080);
    print("Socks5 proxy server started on port 1080");
  }
}
