import 'package:laboratorio_prueba/models/audit.dart';
import 'package:sqflite/sqflite.dart';

class AuditDatabaseHelper {
  // Define a private constructor to prevent instantiation from outside
  AuditDatabaseHelper._privateConstructor();

  static final AuditDatabaseHelper instance = AuditDatabaseHelper._privateConstructor();

  static const _databaseName = 'example_database.db';
  static const _databaseVersion = 1;

  // Function to open the database (or create it if it doesn't exist)
  Future<Database> get database async {
    final databasePath = await getDatabasesPath();
    print('The versions in _databaseVersion is $_databaseVersion');
    return await openDatabase(
      '$databasePath/$_databaseName',
      onCreate: (db, version) {
        // Create the "Audit" table on database creation
        print('The versions in version is $version');
        db.execute('''
          CREATE TABLE Audit(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            action TEXT,
            creation INTEGER NOT NULL);
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async  {
        // Handle database schema upgrades if needed
        // (implement logic for updating existing tables here)
        print('The versions in oldVersion is $oldVersion and newVersion is $newVersion');
        for (int version = oldVersion + 1; version <= newVersion; version++) {
          
          switch (version) {
            case 3:
              // Create a new table with the desired AUTOINCREMENT column
              print('The version is ${version} and Create a new table with the desired AUTOINCREMENT column');
              await db.execute('''
                CREATE TABLE Audit_new(
                  id INTEGER PRIMARY KEY AUTOINCREMENT, 
                  name TEXT,
                  gender TEXT,
                  year INTEGER,
                  version INTEGER)
              ''');

              // Migrate data from the old table to the new table
              final oldData = await db.query('Audit');
              for (final row in oldData) {
                await db.insert('Audit_new', row);
              }

              // Drop the old table after successful migration
              await db.execute('DROP TABLE Audit');

              // Rename the new table to the original name
              await db.execute('ALTER TABLE Audit_new RENAME TO Audit');
              break;
            default:
              throw Exception('Unsupported upgrade version: $version');
          }
        }
      },  
      version: 1,//This version is for determinate the OnCreate, onUpgrade or onDowngrade option. (new version)
    );
  }

  //Fcution to insert Audit
  Future<void> insertAudit(Audit Audit) async {
    final database = await AuditDatabaseHelper.instance.database;
    await database.insert(
      'Audit',
      Audit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Function to get all Audits
  Future<List<Audit>> getAudits() async {
    final database = await AuditDatabaseHelper.instance.database;
    
    final List<Map<String, dynamic>> maps = await database.query('Audit');
    return List.generate(maps.length, (i) => Audit.fromMap(maps[i]));
  }

  //Pending Delete, Update.
  //References
  /* 
    https://pub.dev/packages/sqflite
    https://docs.flutter.dev/cookbook/persistence/sqlite
    https://medium.com/@beccasaka/using-sqlite-in-flutter-3d5a10138090
  
  */

}