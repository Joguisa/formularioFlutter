import 'package:flutter/material.dart';
import 'formulario_datos.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Formulario',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const FormularioDatos(),
//     );
//   }
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Formulario(),
    );
  }
}
