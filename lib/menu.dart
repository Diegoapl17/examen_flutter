import 'package:app_evaluacion/anadirVehiculo.dart';
import 'package:app_evaluacion/listarVehiculos.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //el appBar puede contener un titulo
        appBar: AppBar(
          title: const Center(
              child: Text('Inicio',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 33))),
          backgroundColor: const Color.fromARGB(255, 24, 36, 202),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const SizedBox(
                height: 64,
                width: 50,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 24, 36, 202),
                  ),
                  child: Text(
                    'Gestion de vehiculos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.my_library_books_sharp,
                    color: Color.fromARGB(255, 0, 0, 0)),
                title: const Text('Listar vehiculos'),
                trailing: const Icon(Icons.arrow_forward,
                    color: Color.fromARGB(255, 0, 0, 0)),
                onTap: () {
                  final route = MaterialPageRoute(
                      builder: (context) => const ListarVehiculos());
                  Navigator.push(context, route);
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_circle,
                    color: Color.fromARGB(255, 0, 0, 0)),
                title: const Text('Añadir vehiculo'),
                trailing: const Icon(Icons.arrow_forward,
                    color: Color.fromARGB(255, 0, 0, 0)),
                onTap: () {
                  final route = MaterialPageRoute(
                      builder: (context) => const AnadirVehiculos());
                  Navigator.push(context, route);
                },
              ),
            ],
          ),
        ),
        body: const Text("Evaluacion flutter"));
  }
}
