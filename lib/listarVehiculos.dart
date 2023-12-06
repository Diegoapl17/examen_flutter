import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListarVehiculos extends StatefulWidget {
  const ListarVehiculos({super.key});

  @override
  State<ListarVehiculos> createState() => _ListarVehiculosState();
}

TextEditingController precioDolar = TextEditingController();
TextEditingController precioReparacion = TextEditingController();
TextEditingController precioReparacionDolares = TextEditingController();
TextEditingController totalHorasRparacion = TextEditingController();

class _ListarVehiculosState extends State<ListarVehiculos> {
  List<dynamic> data = []; //almacenar los datos obtneidos de la api

  @override
  void initState() {
    super.initState();
    ObtenerPrecioDolar();
    getVehiculos();
  }

  Future<void> getVehiculos() async {
    final response = await http
        .get(Uri.parse('https://api-vehiculos.onrender.com/api/vehiculo'));

    //si es 200 es porque todo esta bien
    if (response.statusCode == 200) {
      Map<String, dynamic> decodeData = json.decode(response.body);

      setState(() {
        data = decodeData['vehiculos'] ?? [];
        print(data);
      });
    } else {
      print('Revisar el codigo existen fallos ${response.statusCode}');
    }
  }

  Future<void> ObtenerPrecioDolar() async {
    final response = await http.get(Uri.parse(
        'https://www.datos.gov.co/resource/32sa-8pi3.json?vigenciadesde=2023-12-06'));

    if (response.statusCode == 200) {
      // Analizar la respuesta JSON
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        // Obtener el último resultado del precio del dólar
        final Map<String, dynamic> latestData = data.first;
        final String price = latestData['valor'] ?? 'No disponible';

        setState(() {
          precioDolar.text = price;
          print(precioDolar);
        });
      }
    } else {
      // Si la solicitud falla, mostrar un mensaje de error
      setState(() {
        precioDolar.text = 'Error al obtener el precio del dólar';
      });
    }
  }

  var nuevo = precioDolar;
  double precioPes = 0;
  double precioDol = 0;
  double horas = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listar vehiculos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 24, 36, 202),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: data.length, //definimos la cantidad elementos

                itemBuilder: (BuildContext context, int index) {
                  var ss =
                      double.parse(data[index]['precioReparacion'].toString()) /
                          double.parse(nuevo.text);

                  precioReparacion.text = (precioPes += double.parse(
                          data[index]['precioReparacion'].toString()))
                      .toString();

                  precioReparacionDolares.text = (precioDol += double.parse(
                              data[index]['precioReparacion'].toString()) /
                          double.parse(nuevo.text))
                      .toString();

                  totalHorasRparacion.text = (horas += double.parse(
                          data[index]['horasReparacion'].toString()))
                      .toString();
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: ListTile(
                              title: Text(data[index]['numero'].toString()),
                            )),
                            Expanded(
                              child: ListTile(
                                title: Text(data[index]['placa']),
                              ),
                            ),
                            Expanded(
                                child: ListTile(
                              title: Text(
                                  data[index]['horasReparacion'].toString()),
                            )),
                            Expanded(
                              child: ListTile(title: Text("$ss")),
                            ),
                            Expanded(
                                child: ListTile(
                              title: Text(data[index]['observaciones']),
                            )),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(width: 4),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: Text("Total de horasReparacion "),
                        labelStyle: TextStyle(color: Colors.black)),
                    controller: totalHorasRparacion,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: Text("Total precioReparacion pesos"),
                        labelStyle: TextStyle(color: Colors.black)),
                    controller: precioReparacion,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        label: Text("Total precioReparacion dolares"),
                        labelStyle: TextStyle(color: Colors.black)),
                    controller: precioReparacionDolares,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
