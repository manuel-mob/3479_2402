
import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeListScreen extends StatelessWidget {
  final List<Recipe> recipes;

  RecipeListScreen({required this.recipes});

   @override
  Widget build(BuildContext context) {


    
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe List'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                // Navegar a una pantalla de detalles con los detalles de la receta
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailScreen(recipe: recipe),
                  ),
                );
              },
              child: Stack(
                children: [
                  // Imagen de fondo
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(recipe.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // Contenido de la tarjeta
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            backgroundColor: Colors.black54,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Duración: ${recipe.score}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                backgroundColor: Colors.black54,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Nivel: ${recipe.score}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                backgroundColor: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Icono de corazón en la parte superior derecha
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: Icon(
                        recipe.favorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        // Lógica para marcar como favorito
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailScreen({required this.recipe});

  @override 

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Padding(
        padding: 
 EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              recipe.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text('Creation Date: ${recipe.creationDate}'),
            SizedBox(height: 8),
            Text('Update Date: ${recipe.updateDate}'),
            SizedBox(height: 8),
            Text('Score: ${recipe.score}'),
            SizedBox(height: 8),
            Text('State: ${recipe.state}'),
          ],
        ),
      ),
    );
  }
}