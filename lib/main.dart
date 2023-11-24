import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weather_app/forecastapi.dart';
import 'package:weather_app/homepage.dart';
import 'package:weather_app/weatherapi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Weatheritems>(create: (context) => Weatheritems()),
      ChangeNotifierProvider<Forecastitems>(
          create: (context) => Forecastitems()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
