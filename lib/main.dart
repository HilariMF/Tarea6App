import 'package:flutter/material.dart';
import 'package:tarea6/SideMenu.Screen/sidemenu.dart';

void main() {
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
      home: const MyHomePage(title: 'Tarea 6'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() =>
      _MyHomePageState(imageUrl: 'lib/Cajas-de-herramientas.png');
}

class _MyHomePageState extends State<MyHomePage> {
  String imageUrl = 'lib/Cajas-de-herramientas.png';

  _MyHomePageState({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
      ),
      body: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
