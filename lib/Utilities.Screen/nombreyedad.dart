import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edad extends StatefulWidget {
  const Edad({super.key});

  @override
  _EdadState createState() => _EdadState();
}

class _EdadState extends State<Edad> {
  final TextEditingController _nameController = TextEditingController();
  String age = '';
  String image = '';

  Future<Map> _fetchData(String name) async {
    final uri = Uri.parse('https://api.agify.io/?name=$name');
    final response = await http.get(uri);
    return _parseJsonResponse(response.body);
  }

  Map _parseJsonResponse(String jsonString) {
    final regex = RegExp('"age":\\s*(\\d+)');
    final match = regex.firstMatch(jsonString);

    if (match != null) {
      return {
        'age': match.group(1),
      };
    } else {
      return {
        'age': '0',
      };
    }
  }

  void updateImage(int userAge) {
    if (userAge < 18) {
      image = 'lib/joven.jpg';
    } else if (userAge >= 18 && userAge < 60) {
      image = 'lib/adulto.jpg';
    } else {
      image = 'lib/anciano.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edad'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Nombre'),
          ),
          ElevatedButton(
            onPressed: () async {
              final ageData = await _fetchData(_nameController.text);
              final userAge = int.tryParse(ageData['age'] ?? '0') ?? 0;
              setState(() {
                age = userAge.toString();
                updateImage(userAge);
              });
            },
            child: const Text('Predecir'),
          ),
          if (image.isNotEmpty) // Verifica si hay una imagen para mostrar
            Image.asset(
              image,
              width: 200,
            ),
          Text('Edad: $age'),
        ],
      ),
    );
  }
}
