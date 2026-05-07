import 'package:el_bershama/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({super.key});

  void goHome(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الأدوية"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => goHome(context),
        ),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () => goHome(context),
          child: const Text("الرجوع للرئيسية"),
        ),
      ),
    );
  }
}