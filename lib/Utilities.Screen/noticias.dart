import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Noticias extends StatefulWidget {
  const Noticias({super.key});

  @override
  _Noticias createState() => _Noticias();
}

class _Noticias extends State<Noticias> {
  // API key de NewsAPI
  final String apiKey = '51f750d538c44963a9946c33389bcad6';

  // Lista de noticias
  List<Map<String, dynamic>> _noticias = [];

  @override
  void initState() {
    super.initState();

    // Obtener las últimas noticias
    _obtenerNoticias();
  }

  // Obtener las últimas noticias
  Future<void> _obtenerNoticias() async {
    // Crear la consulta
    final query = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&language=en&apiKey=$apiKey');

    // Realizar la solicitud HTTP
    final response = await http.get(query);

    // Decodificar la respuesta JSON
    final jsonResponse = jsonDecode(response.body);

    // Verificar si la respuesta es válida
    if (jsonResponse['status'] == 'ok') {
      // Actualizar la lista de noticias
      _noticias = jsonResponse['articles'].cast<Map<String, dynamic>>();

      // Actualizar el estado
      setState(() {});
    } else {
      // Mostrar un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al cargar las noticias'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias'),
      ),
      body: ListView.builder(
        itemCount: _noticias.length,
        itemBuilder: (context, index) {
          // Obtener la noticia
          final noticia = _noticias[index];

          // Obtener la imagen de la noticia
          final imagen = noticia['urlToImage'] ?? 'https://example.com/default.png';

          // Crear el widget de la noticia
          return Card(
            child: ListTile(
              leading: Image.network(imagen),
              title: Text(noticia['title']),
              subtitle: Text(noticia['description']),
              onTap: () {
                // Abrir la noticia en el navegador
                // launch(noticia['url']);
              },
            ),
          );
        },
      ),
    );
  }
}

