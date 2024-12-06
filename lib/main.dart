import 'package:flutter/material.dart';
import 'package:recrutment_it_solutions_management_international_pte/widgets/app_icon.dart';
import 'package:recrutment_it_solutions_management_international_pte/widgets/dock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white70,
        body: Center(
          child: Dock(
            items: const [
              Icons.person,
              Icons.message,
              Icons.call,
              Icons.camera,
              Icons.photo,
            ],
            builder: (e, isDragged) {
              return AppIcon(
                iconData: e,
                isDragged: isDragged,
              );
            },
          ),
        ),
      ),
    );
  }
}
