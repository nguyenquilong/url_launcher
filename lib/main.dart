import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:platform/platform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void handlePayment(BuildContext context) {
    if (const LocalPlatform().isAndroid) {
      handlePaymentFromAndroid();
    } else if (const LocalPlatform().isIOS) {
      handlePaymentFromIos(context);
    }
  }


  //  _launchURL() async {
  //   const url = 'intent://your_intent_url_here';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  void handlePaymentFromAndroid() async {
    const upiPaymentUrl =
        'f5smartaccount://view?data=00020101021226280010A000000775011003127764865204074253037045405100005802VN5905SENDO6005HANOI62620309SENDO+WEB051901240111143827580130708SENDOW010810TEST%2bA%2bB%2bC63042CB7&callbackurl=https%3a%2f%2fwww.sendo.vn/#Intent;scheme=f5smartaccount;package=vnpay.smartacccount;end';
    final uri = Uri.parse(upiPaymentUrl);
    // await launchUrl(uri); 
    // if (await launchUrl(uri)) {
    //   await launch(uri);
    // } else {
    //   throw 'Could not launch $uri';
    // }
    launchUrl(uri).then((value) {
      if (value) {
        print(value.toString());
        print('Succesfully came back to app android');
      } else {
        print('cant launch');
      }
    });
  }

  void handlePaymentFromIos(BuildContext context) async {
    final upiAppSchemeList = ['phonepe', 'tez', 'paytm', 'intent'];
    List<String> listOfUpiApps = [];
    const payUrl =
        'pay?pa=dinesh@dlanzer&pn=Dinesh&am=1&tn=Test Payment&cu=INR';

    for (final appSceme in upiAppSchemeList) {
      final combinedUrl = '$appSceme://$payUrl';
      final uri = Uri.parse(combinedUrl);

      final result = await canLaunchUrl(uri);
      print('Result for $appSceme is $result');
      if (result == true) {
        listOfUpiApps.add(appSceme);
      }
    }

    showAdaptiveDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
            itemCount: listOfUpiApps.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: () async {
                  await launchSpecificUrlFromIos(
                      createPaymentUrl(listOfUpiApps[index], payUrl));
                  Navigator.pop(context);
                },
                child: Text(listOfUpiApps[index]),
              );
            },
          );
        });
  }

  String createPaymentUrl(String scheme, String payUrl) {
    return '$scheme://$payUrl';
  }

  Future<void> launchSpecificUrlFromIos(String url) async {
    final uri = Uri.parse(url);

    final result = await launchUrl(uri);
    if (result) {
      print('Succesfully came back to app');
    } else {
      print('cant launch');
    }
  }

  // void checkIfPhonePeInstalled() async {
  //   setState(() {
  //     listOfApps = '.....';
  //   });
  //   final upiAppSchemeList = ['phonepe', 'tez', 'paytm'];
  //   const payUrl =
  //       'pay?pa=dinesh@dlanzer&pn=Dinesh&am=1&tn=Test Payment&cu=INR';

  //   for (final appSceme in upiAppSchemeList) {
  //     final combinedUrl = '$appSceme://$payUrl';
  //     final uri = Uri.parse(combinedUrl);

  //     final result = await canLaunchUrl(uri);
  //     setState(() {
  //       if (result == true) {
  //         listOfApps = '$listOfApps $appSceme';
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'List of Apps installed',
            ),
            Text(
              '',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          handlePayment(context);
        },
        tooltip: 'Increment',
        child: const Text('Pay'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}