import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tarea6/SideMenu.Screen/sidemenu.dart';

class NombreGenero extends StatelessWidget {
  const NombreGenero({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NombreYGenero(),
    );
  }
}

class NombreYGenero extends StatefulWidget {
  const NombreYGenero({super.key});

  @override
  _NombreYGeneroState createState() => _NombreYGeneroState();
}

class _NombreYGeneroState extends State<NombreYGenero> {
  final TextEditingController _nameController = TextEditingController();
  Color appBarColor = Colors.blue; // Color de la AppBar predeterminado

  Future<Map> _fetchData(String name) async {
    final uri = Uri.parse('https://api.genderize.io/?name=$name');
    final response = await http.get(uri);
    return _parseJsonResponse(response.body);
  }

  Map _parseJsonResponse(String jsonString) {
    final regex = RegExp('"gender":\\s*"([^"]+)"');
    final match = regex.firstMatch(jsonString);

    if (match != null) {
      final gender = match.group(1);
      // Actualizar el color de la AppBar y el botón
      setState(() {
        if (gender == 'male') {
          appBarColor = Colors.blue;
        } else {
          appBarColor = Colors.pink;
        }
      });
      return {'gender': gender};
    } else {
      // Si no se encuentra género, asumimos femenino y actualizamos el color
      setState(() {
        appBarColor = Colors.pink;
      });
      return {'gender': 'female'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Genero'),
        backgroundColor: appBarColor, // Color de la AppBar actualizado
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Nombre'),
          ),
          ElevatedButton(
            onPressed: () async {
              final gender = await _fetchData(_nameController.text);

              if (gender['gender'] == 'male') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El género es masculino'),
                    backgroundColor: Colors.blue,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El género es femenino'),
                    backgroundColor: Colors.pink,
                  ),
                );
              }
            },
            child: const Text('Predecir'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  appBarColor), // Color del botón actualizado
            ),
          ),
        ],
      ),
    );
  }
}
