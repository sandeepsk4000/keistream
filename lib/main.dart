

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project1/screens/splash_screen.dart';

import 'model/data_model.dart';

Future main() async {

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(VideoModelAdapter().typeId)) {
    Hive.registerAdapter(VideoModelAdapter());
  }
  if (!Hive.isAdapterRegistered(FavouriteModelAdapter().typeId)) {
    Hive.registerAdapter(FavouriteModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListVideoModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListVideoModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kei Stream',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
