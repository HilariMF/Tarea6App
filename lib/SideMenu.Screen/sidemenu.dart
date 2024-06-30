import 'package:flutter/material.dart';
import 'package:tarea6/Utilities.Screen/contratame.dart';
import 'package:tarea6/Utilities.Screen/noticias.dart';
import 'package:tarea6/Utilities.Screen/clima.dart';
import 'package:tarea6/Utilities.Screen/nombreyedad.dart';
import 'package:tarea6/Utilities.Screen/nombreygenero.dart';
import 'package:tarea6/Utilities.Screen/universidades.dart';
import 'package:tarea6/main.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 58, 55, 55),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: const Text('Hilari Medina',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: const Text('2022-1025',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              currentAccountPicture: CircleAvatar(
                child: Image.asset(
                  'lib/foto2x2.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  image: DecorationImage(
                    image: AssetImage('lib/programacion.jpg'),
                    fit: BoxFit.cover,
                  ))),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: const Text('Inicio', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyApp()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person_3_outlined, color: Colors.white),
            title: const Text('Nombre y Genero',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NombreGenero(
                            key: UniqueKey(),
                          )));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_2, color: Colors.white),
            title: const Text('Nombre y Edad',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Edad()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.school, color: Colors.white),
            title: const Text('Buscar Universidades',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UniversityList()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.cloud, color: Colors.white),
            title: const Text('Clima en RD',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WeatherApp(
                          apiKey: '6fa6af9d98033eb5b9e8e8353a058682')));
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper, color: Colors.white),
            title:
                const Text('Noticias', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Noticias()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.white),
            title:
                const Text('Contratame', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Contratame()));
            },
          ),
        ],
      ),
    );
  }
}
