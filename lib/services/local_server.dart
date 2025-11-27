import 'dart:io';

class LocalServer {
  HttpServer? server;

  Future<void> start(int port) async {
    server = await HttpServer.bind(InternetAddress.anyIPv4, port);

    server!.listen((HttpRequest request) async {
      request.response
        ..statusCode = 200
        ..write("Your Flutter app is running on WiFi!")
        ..close();
    });
  }

  Future<void> stop() async {
    await server?.close();
    server = null;
  }
}
