// MainActivity.java
// package com.example.url_laucher;

// import io.flutter.embedding.android.FlutterActivity;
// import io.flutter.embedding.engine.FlutterEngine;
// import io.flutter.plugins.GeneratedPluginRegistrant;
// // MainActivity.java
// public class MainActivity extends FlutterActivity {
//     @Override
//     public void configureFlutterEngine(FlutterEngine flutterEngine) {
//         GeneratedPluginRegistrant.registerWith(flutterEngine);

//         new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "your_channel")
//                 .setMethodCallHandler(
//                         (call, result) -> {
//                             // Handle native method calls here
//                             if (call.method.equals("openIntentUrl")) {
//                                 String url = call.argument("url");
//                                 // Call the native method to open the intent URL
//                                 openIntentUrl(url);
//                                 result.success(null); // Indicate success to Flutter
//                             } else {
//                                 result.notImplemented(); // Handle unknown method calls
//                             }
//                         }
//                 );
//     }

//     // Native method to open the intent URL
//     private void openIntentUrl(String url) {
//         Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
//         startActivity(intent);
//     }
// }


package com.example.url_laucher;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
};