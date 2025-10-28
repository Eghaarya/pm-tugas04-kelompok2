import 'package:flutter/material.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/detail_page.dart';
import 'pages/edit_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daftar Mahasiswa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
        '/about': (context) => AboutPage(),
        '/detail': (context) => DetailPage(),
        '/edit': (context) => EditPage(),
      },
    );
  }
}
