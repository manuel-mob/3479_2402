import 'package:flutter/material.dart';
import 'package:laboratorio_prueba/models/feriado.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class FeriadoListScreen extends StatefulWidget {
  late List<Feriado> feriados;
  late int year;

  FeriadoListScreen() {
    feriados = [];
    year = 2024;
  }

  @override
  _FeriadoListScreenState createState() => _FeriadoListScreenState();
}

class _FeriadoListScreenState extends State<FeriadoListScreen> {
  @override
  void initState() {
    super.initState();
    fetchFeriados().then((feriados) {
      // Do something with the fetched feriados
      setState(() {
        widget.feriados.addAll(feriados);
      });
    }).catchError((error) {
      // Handle the error
    });
  }

  Future<List<Feriado>> fetchFeriados() async {
    final response = await http.get(Uri.parse('https://apis.digital.gob.cl/fl/feriados/'+widget.year.toString()));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Feriado.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load feriados');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feriados ${widget.year}'),
      ),
      body: 
          ListView.builder(
          itemCount: widget.feriados.length,
          itemBuilder: (context, index) {
            final feriado = widget.feriados[index];
            return ListTile(
              title: Text(feriado.nombre),
              subtitle: Text(feriado.fecha.toIso8601String()),
              trailing: Text(feriado.tipo),
            );
          },
        ),
    );
  }
}
 