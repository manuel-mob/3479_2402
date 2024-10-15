import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laboratorio_prueba/pages/audit.dart';
import 'package:laboratorio_prueba/pages/preference.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/appprovider.dart';
import '../models/recipe.dart';
import 'about.dart';
import 'list_recipe.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;


  //@override
  //State<MyHomePage> createState() => _MyHomePageState();
  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() {
    var logger = Logger();
    logger.d("create state");
    return _MyHomePageState();
  }
}
class _MyHomePageState extends State<MyHomePage> {
  String message = '';
  String welcome_message = 'Hola';
  int _counter = 0;
  String _userName = '';

  @override 
  void initState() {
    super.initState();
    var logger = Logger();
    logger.d("initState() called.");
    message = "Hello World!";
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
      _userName = prefs.getString('userName') ?? '';
      if (_userName != '') {
        welcome_message = 'Hola $_userName';
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    var logger = Logger();
    logger.d("dispose() called.");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadPreferences();
     var logger = Logger();
    logger.d("didChangeDependencies() called.");
  }

  @override
  Widget build(BuildContext context) {
     var logger = Logger();
      logger.d("Logger is working!");
      final appData = context.watch<AppData>();

      String svg = 'assets/icons/211668_game_icon.svg';

    var drawer = Drawer(
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text('Drawer Header'),
      ),
      ListTile(
        title: const Text('Mis Receptas'),
        onTap: () {

              final List<Recipe> recipes;
    recipes = [
              Recipe(
                id: 1,
                name: 'Chocolate Cake',
                creationDate: DateTime.now(),
                updateDate: DateTime.now(),
                description: 'A delicious chocolate cake recipe.',
                score: 5,
                state: 'Published',
                favorite: true,
                image: 'https://as1.ftcdn.net/v2/jpg/01/31/05/30/1000_F_131053005_61aYiIU3MbSJU2lU5uSBbU6qdX87rXLn.jpg',
              ),
              Recipe(
                id: 2,
                name: 'Spaghetti Bolognese',
                creationDate: DateTime.now(),
                updateDate: DateTime.now(),
                description: 'A classic Italian pasta dish.',
                score: 4,
                state: 'Draft',
                favorite: false,
                image: 'https://images.pexels.com/photos/10273537/pexels-photo-10273537.jpeg'
              ),
              Recipe(
                id: 3,
                name: 'Grilled Chicken Salad',
                creationDate: DateTime.now(),
                updateDate: DateTime.now(),
                description: 'A healthy and refreshing salad.',
                score: 3,
                state: 'Published',
                favorite: true,
                image: 'https://as1.ftcdn.net/v2/jpg/01/31/05/30/1000_F_131053005_61aYiIU3MbSJU2lU5uSBbU6qdX87rXLn.jpg',
              ),
            ];

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipeListScreen(recipes: recipes)),
          );

        },
      ),
      ListTile(
        title: const Text('About'),
        onTap: () {
          // Update the state of the app.
          // ...
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutApp()),
          );
          
        },
      ),
      ListTile(
        title: const Text('Audits'),
        onTap: () {
          // Update the state of the app.
          // ...
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Audit()),
          );
          
        },
      ),
            ListTile(
        title: const Text('Preferences'),
        onTap: () {
          // Update the state of the app.
          // ...
             Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PreferenceApp()
            )
          ).then((_) {
            _loadPreferences();
          });
          
        },
      ),
    ],
  ),
);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: drawer,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Card(
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: 
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          SvgPicture.asset('assets/icons/293657_x_icon.svg'),
                          SizedBox(width: 20,),
                          SvgPicture.asset('assets/icons/293667_circle_icon.svg'),
                          SizedBox(width:20,),
                          SvgPicture.asset(svg,
                          semanticsLabel: 'Game',
                          width: 40),
                      ],
                      ),
                  ),
                ),
                Text(
                  welcome_message,
                ),
                Text(
                  message,
                ),
                Text(
                  //' ${appData.counter}',
                 //'${context.read<AppData>().counter}', 
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text("Nuevo texto",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),)
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: context.read<AppData>().incrementCounter, 
          child: Icon(Icons.ac_unit_outlined)),
        ElevatedButton(
          onPressed: context.read<AppData>().incrementCounter, 
          child: Icon(Icons.headphones))
      ], // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
