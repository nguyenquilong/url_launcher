// lib/my_channel.dart
import 'package:flutter/services.dart';

const platform = MethodChannel('your_channel');

Future<void> openIntentUrl(String url) async {
  try {
    await platform.invokeMethod('openIntentUrl', {'url': url});
  } on PlatformException catch (e) {
    print("Failed to open intent URL: ${e.message}");
  }
}
