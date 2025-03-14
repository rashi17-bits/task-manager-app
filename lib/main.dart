import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  const String back4appApplicationId = "YOUR_BACK4APP_APPLICATION_ID";
  const String back4appClientKey = "YOUR_BACK4APP_CLIENT_KEY";
  const String back4appParseServerUrl = "https://parseapi.back4app.com";
 
  await Parse().initialize(
    back4appApplicationId,
    back4appParseServerUrl,
    clientKey: back4appClientKey,
    autoSendSessionId: true,
  );
 
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
 
  @override
  void initState() {
    super.initState();
    _fetchCounterValue();
  }
 
  void _fetchCounterValue() async {
    final query = QueryBuilder<ParseObject>(ParseObject('Counter'))
      ..setLimit(1)
      ..orderByDescending('createdAt');
 
    final response = await query.query();
 
    if (response.success && response.results != null) {
      setState(() {
        _counter = response.results!.first.get<int>('count') ?? 0;
      });
    }
  }
 
  void _incrementCounter() async {
    final testObject = ParseObject('Counter')..set('count', _counter + 1);
    await testObject.save();
 
    setState(() {
      _counter++;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}