import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'screens/login_screen.dart';
import 'screens/task_list_screen.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  const String back4appApplicationId = "TlNjgcLvH9VB8XCzOrkiib5fMcCpZERE5jm2XiKK";
  const String back4appClientKey = "OoPcnnKG3zuZC8f7fcL1fXWvMqFd6pzYNzijbFq6";
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
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Starting point of the app
      routes: {
        '/': (context) => LoginScreen(), // Login screen route
        '/taskPage': (context) => TaskListScreen(), // Task list screen route
      },
    );
  }
}