import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('fnn.ramadani.id/test_drive');
  String _testDrive = 'Unknown data';

  @override
  void initState() {
    super.initState();

    platform.setMethodCallHandler((call) => _responseFromPlatform(call));
  }

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
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_testDrive),
            RaisedButton(
              child: Text('Test Drive'),
              onPressed: () => _getTestDrive(),
            ),
            RaisedButton(
              child: Text('Notification'),
              onPressed: () => _showNotification(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getTestDrive() async {
    String testDrive;

    try {
      final String result = await platform.invokeMethod('getTestDrive');
      testDrive = 'Test Drive value: $result';
    } on PlatformException catch (e) {
      testDrive = 'Failed to get test drive value: ${e.message}';
    }

    setState(() {
      _testDrive = testDrive;
    });
  }

  Future<void> _showNotification() async {
    try {
      await platform.invokeMethod("notification");
    } on PlatformException catch (e) {
      debugPrint('Failed to show notification: ${e.message}');
    }
  }

  _responseFromPlatform(MethodCall call) {
    if (call.method == "setTestDrive") {
      final String testDrive = call.arguments;

      setState(() {
        _testDrive = testDrive;
      });
    }
  }
}
