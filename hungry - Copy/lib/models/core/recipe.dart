class Recipe {
  String title;
  String photo;
  String calories;
  String time;
  String description;

  List<Ingredients> ingredients;
  List<TutorialStep> tutorial;
  List<Review> reviews;

  Recipe({required this.title,required this.photo, required this.calories, required this.time, required this.description, required this.ingredients, required this.tutorial, required this.reviews});

  factory Recipe.fromJson(Map<String, Object?> json) {
    return Recipe(
      title: json['title'] as String? ?? 'Default Title',  // Cast to String? and provide a fallback if null
      photo: json['photo'] as String? ?? '',  // Cast to String? and provide a fallback if null
      calories: json['calories'] as String? ?? '0 Cal',  // Cast to String? and provide a fallback if null
      time: json['time'] as String? ?? '0 min',  // Cast to String? and provide a fallback if null
      description: json['description'] as String? ?? 'No description available.',  // Cast to String? and provide a fallback if null
      ingredients: json['ingredients'] is List
          ? List.from(json['ingredients'] as List)  // Ensure it's a List
          : [],  // Default to an empty list if it's not a List
      tutorial: json['tutorial'] is List
          ? List.from(json['tutorial'] as List)  // Ensure it's a List
          : [],  // Default to an empty list if it's not a List
      reviews: json['reviews'] is List
          ? List.from(json['reviews'] as List)  // Ensure it's a List
          : [],  // Default to an empty list if it's not a List
    );
  }

}


class TutorialStep {
  String step;
  String description;
  TutorialStep({required this.step,required this.description});

  Map<String, Object> toMap() {
    return {
      'step': step,
      'description': description,
    };
  }

  factory TutorialStep.fromJson(Map<String, Object?> json) {
    return TutorialStep(
      step: json['step'] as String? ?? 'Default Step',  // Cast to String? and provide a fallback if null
      description: json['description'] as String? ?? 'No description available.',  // Cast to String? and provide a fallback if null
    );
  }


  static List<TutorialStep> toList(List<Map<String, Object>> json) {
    return List.from(json).map((e) => TutorialStep(step: e['step'], description: e['description'])).toList();
  }
}

class Review {
  String username;
  String review;
  Review({required this.username,required this.review});

  factory Review.fromJson(Map<String, Object?> json) {
    return Review(
      review: json['review'] as String? ?? 'No review provided',  // Cast to String? and provide a default value if null
      username: json['username'] as String? ?? 'Anonymous',  // Cast to String? and provide a default value if null
    );
  }


  Map<String, Object> toMap() {
    return {
      'username': username,
      'review': review,
    };
  }

  static List<Review> toList(List<Map<String, Object>> json) {
    return List.from(json).map((e) => Review(username: e['username'], review: e['review'])).toList();
  }
}

class Ingredients {
  String name = '';
  String size = '';

  Ingredients({required this.name, required this.size});


  factory Ingredients.fromJson(Map<String, Object?> json) {
    return Ingredients(
      name: json['name'] as String? ?? 'Default Name', // Cast to String? and provide a default value if null
      size: json['size'] as String? ?? 'Default Size', // Cast to String? and provide a default value if null
    );
  }


  Map<String, Object> toMap() {
    return {
      'name': name,
      'size': size,
    };
  }

  static List<Ingredients> toList(List<Map<String, Object>> json) {
    return List.from(json).map((e) => Ingredients(name: e['name'], size: e['size'])).toList();
  }
}
