import 'package:flutter/material.dart';
import 'package:laboratorio_prueba/models/audit.dart';
import 'package:laboratorio_prueba/utils/audit_database_helper.dart';
import 'package:provider/provider.dart';

import '../models/appprovider.dart';

class AuditScreen extends StatefulWidget {
  @override
  State<AuditScreen> createState() => _AuditScreenState();
}

class _AuditScreenState extends State<AuditScreen> {
  late Future<List<Audit>> _auditList;
  
  @override
  void initState() {
    super.initState();
    _auditList = AuditDatabaseHelper.instance.getAudits();

    //Insert one Audit
    AuditDatabaseHelper.instance.insertAudit(Audit(action: 'Access to Audit Screen', creation: DateTime.now()));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Audit Page'),
      ),
      body: FutureBuilder<List<Audit>>(
        future: _auditList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Handle errors
          } else {
            final games = snapshot.data!; // Access the list of games
            return ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return ListTile(
                  title: Text(game.action!),
                  subtitle: Text('Creation date: ${game.creation}'),
                  //onTap: () => _showGameDetails(game), // Call function to show details
                );
              },
            );
          }
        },
      ),
    );
  }
}