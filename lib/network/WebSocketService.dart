import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

typedef MessageCallback = void Function(Map<String, dynamic>);

class WebSocketService {
  WebSocketChannel? _channel; // Allow _channel to be nullable
  StreamSubscription<Map<String, dynamic>>? _subscription;

  // Connect to a WebSocket server and call onMessageReceived for each message
  void connect(String url, MessageCallback onMessageReceived) {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(url));

      // If the connection is successful and the stream is available, listen to the stream
      if (_channel != null) {
        _listenToStream(_channel!.stream, onMessageReceived);
      }
    } catch (e) {
      // Handle connection errors (you might want to add further error handling)
      print('Failed to connect to WebSocket: $e');
    }
  }

  // Send a message to the WebSocket server
  void sendMessage(Map<String, dynamic> message) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode(message));
    } else {
      throw Exception('WebSocket is not connected');
    }
  }

  // Close the WebSocket connection safely
  void close() {
    _subscription?.cancel();
    _channel?.sink.close();
    _channel = null;
  }

  // Listen to the WebSocket stream and invoke the callback for each message
  void _listenToStream(
      Stream<dynamic> stream, MessageCallback onMessageReceived) {
    // Cancel any existing subscription to avoid multiple listeners
    _subscription?.cancel();

    // Wrap and listen to the stream, then pass each parsed message to the callback
    _subscription = _wrapStream(stream).listen((message) {
      onMessageReceived(message);
    }, onError: (error) {
      print('WebSocket error: $error');
    }, onDone: () {
      print('WebSocket connection closed.');
    });
  }

  // Parse a WebSocket message into a Map<String, dynamic>
  Map<String, dynamic>? _parseMessage(dynamic message) {
    try {
      final decodedData = jsonDecode(message) as Map<String, dynamic>;
      if (decodedData.containsKey('event') && decodedData.containsKey('data')) {
        return decodedData;
      } else {
        print('Invalid data format received from WebSocket.');
      }
    } catch (e) {
      print('Failed to parse data from WebSocket: $e');
    }
    return null;
  }

  // Wrap the WebSocket stream to convert messages into Map<String, dynamic>
  Stream<Map<String, dynamic>> _wrapStream(Stream<dynamic> stream) {
    return stream.map((message) {
      return _parseMessage(message) ?? {};
    }).where((data) => data.isNotEmpty);
  }
}
