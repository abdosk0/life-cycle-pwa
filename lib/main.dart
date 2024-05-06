import 'package:flutter/material.dart';
import 'dart:js' as js;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (js.context.hasProperty('serviceWorker')) {
    js.context.callMethod('serviceWorker.register', ['service_worker.js']);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  String _lifecycleState = 'Unknown';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateLifecycleState('initialized');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _updateLifecycleState('disposed');
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _updateLifecycleState(state.toString());
  }

  void _updateLifecycleState(String newState) {
    setState(() {
      _lifecycleState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PWA Lifecycle Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'App Lifecycle State:',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              _lifecycleState,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
