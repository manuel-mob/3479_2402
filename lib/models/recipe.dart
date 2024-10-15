class Recipe {
  final int id;
  final String name;
  final DateTime creationDate;
  final DateTime updateDate;
  final String description;
  final int score;
  final String state;
  final bool favorite;
  final String image;

  Recipe({
    required this.id,
    required this.name,
    required this.creationDate,
    required this.updateDate,
    required this.description,
    required this.score,
    required this.state,
    required this.favorite,
    required this.image,
  });
}