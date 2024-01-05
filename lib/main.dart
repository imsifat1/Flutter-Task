import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_imran/route/route_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(
      fileName: kDebugMode ? ".env.development" : ".env.production");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: RouteManager.generate,
      initialRoute: RouteManager.initialRoute,
    );
  }
}
