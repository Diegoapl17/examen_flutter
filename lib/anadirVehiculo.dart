import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class AnadirVehiculos extends StatefulWidget {
  const AnadirVehiculos({super.key});

  @override
  State<AnadirVehiculos> createState() => _AnadirVehiculoState();
}

class _AnadirVehiculoState extends State<AnadirVehiculos> {
  final numero = TextEditingController();
  final placa = TextEditingController();
  final horasReparacion = TextEditingController();
  final precioReparacion = TextEditingController();
  final observaciones = TextEditingController();

  @override
  void initState() {
    super.initState();
    postVehiculos();
  }

  Future<void> postVehiculos() async {
    final uri = Uri.parse("https://api-vehiculos.onrender.com/api/vehiculo");
    final response = await http.post(uri,
        body: jsonEncode({
          'numero': int.parse(numero.text),
          'placa': placa.text,
          'horasReparacion': int.parse(horasReparacion.text),
          'precioReparacion': int.parse(precioReparacion.text),
          'observaciones': observaciones.text,
        }),
        headers: {'Content-Type': 'Application/json'});

    //si es 200 es porque todo esta bien
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
      });
    } else {
      print('Revisar el codigo existen fallos ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formProd = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar productos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 24, 36, 202),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Form(
              key: formProd,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Diligencie el siguiente formulario"),
                            ),
                            TextFormField(
                              controller: numero,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  label: Text('Numero'),
                                  labelStyle: TextStyle(color: Colors.black)),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Este campo es requerido';
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: placa,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  label: Text('Placa'),
                                  labelStyle: TextStyle(color: Colors.black)),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Este campo es requerido';
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: horasReparacion,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  label: Text('Horas de reparacion'),
                                  labelStyle: TextStyle(color: Colors.black)),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Este campo es requerido';
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: precioReparacion,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  label: Text('Precio reparacion'),
                                  labelStyle: TextStyle(color: Colors.black)),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Este campo es requerido';
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: observaciones,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  label: Text('Observaciones'),
                                  labelStyle: TextStyle(color: Colors.black)),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Este campo es requerido';
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  autofocus: true,
                                  onPressed: () {
                                    if (!formProd.currentState!.validate()) {
                                      print('Formulario no valido');
                                      return;
                                    } else {
                                      Alert(
                                        context: context,
                                        type: AlertType.success,
                                        title: "Producto añadido con exito",
                                      ).show();
                                      postVehiculos();
                                      numero.clear();
                                      placa.clear();
                                      horasReparacion.clear();
                                      precioReparacion.clear();
                                      observaciones.clear();
                                    }
                                  },
                                  child: const Text("Añadir ",
                                      style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 24, 36, 202))),
                            )
                          ],
                        ))
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
