import 'package:flutter/material.dart';
import 'package:spacez_coupons/pages/coupons_screen.dart';


void main() {
  runApp(const SpacezApp());
}

class SpacezApp extends StatelessWidget {
  const SpacezApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Spacez Coupons",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        cardTheme: CardThemeData(
          elevation: 0,
          surfaceTintColor: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const CouponsPage(),
    );
  }
}
