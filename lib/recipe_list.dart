import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'recipe_model.dart';

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  late Future<List<Recipe>> _recipeListFuture;

  @override
  void initState() {
    super.initState();
    _recipeListFuture = _fetchRecipeList();
  }

 Future<List<Recipe>> _fetchRecipeList() async {
  final jsonString = await rootBundle.loadString('assets/recipes.json');
  final jsonList = json.decode(jsonString)['recipes'] as List;
  return jsonList.map((json) => Recipe.fromJson(json)).toList();
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: _recipeListFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final recipes = snapshot.data!;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return ListTile(
                title: Text(recipe.title),
                subtitle: Text(recipe.description),
                onTap: () {
                  showDialog(
                    context: context,
                   builder: (context) {
                     return AlertDialog(
                      title:  Text("ingredients of :${recipe.title}"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          
                            Text(recipe.ingredients.toString()),
                            ElevatedButton(onPressed: (){
                              Navigator.pop(context);
                              }, 
                              child: Text("close"))
                        ],
                      ),
                     );
                   }
                   );
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
