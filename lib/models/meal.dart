import 'package:fitatu_clone/models/models.dart';

class Meal {
  const Meal({
    required this.name,
    this.products = const [],
  });

  final String name;
  final List<Product> products;

  double get kcal {
    return products.fold(
      0,
      (previousValue, element) => previousValue + element.kcal,
    );
  }

  double get protein {
    return products.fold(
      0,
      (previousValue, element) => previousValue + element.protein,
    );
  }

  double get fat {
    return products.fold(
      0,
      (previousValue, element) => previousValue + element.fat,
    );
  }

  double get carb {
    return products.fold(
      0,
      (previousValue, element) => previousValue + element.carb,
    );
  }
}
