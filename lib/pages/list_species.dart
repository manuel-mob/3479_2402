import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laboratorio_prueba/models/specie.dart';
import 'package:http/http.dart' as http;

class SpeciesListScreen extends StatefulWidget {
  @override
  _SpeciesListScreenState createState() => _SpeciesListScreenState();
}

class _SpeciesListScreenState extends State<SpeciesListScreen> {
  List<Species> speciesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSpecies();
  }


  Future<void> fetchSpecies() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/species/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> speciesJson = data['results'];
      setState(() {
        speciesList = speciesJson.map((json) => Species.fromJson(json)).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load species');
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Species List'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: speciesList.length,
              itemBuilder: (context, index) {
                final species = speciesList[index];
                return Card(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://as1.ftcdn.net/v2/jpg/01/31/05/30/1000_F_131053005_61aYiIU3MbSJU2lU5uSBbU6qdX87rXLn.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                species.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Average Height: ${species.averageHeight}',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Skin Colors: ${species.skinColors}',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Hair Colors: ${species.hairColors}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}