import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(
      home: WeatherApp(apiKey: '6fa6af9d98033eb5b9e8e8353a058682'),
    ));

class WeatherApp extends StatefulWidget {
  final String apiKey;

  const WeatherApp({super.key, required this.apiKey});

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String city = 'Santo Domingo,do';
  String weather = '';
  String temperature = '';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${widget.apiKey}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final description = data['weather'][0]['description'];
      final temp = (data['main']['temp'] - 273.15).toStringAsFixed(2);

      setState(() {
        weather = description;
        temperature = '$temp °C';
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('No se pudo cargar los datos del clima.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima en la República Dominicana'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Clima actual en Santo Domingo:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Clima: $weather',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              'Temperatura: $temperature',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
