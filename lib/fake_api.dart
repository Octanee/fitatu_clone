import 'package:fitatu_clone/models/models.dart';

class FakeApi {
  const FakeApi._();

  static final meals = <Meal>[
    Meal(
      name: 'Breakfast',
      products: [
        _products[0],
      ],
    ),
    Meal(
      name: 'Brunch',
      products: [
        _products[0],
        _products[1],
        _products[1],
        _products[1],
        _products[1],
      ],
    ),
    Meal(
      name: 'Lunch',
      products: [
        _products[0],
      ],
    ),
    const Meal(name: 'Snack'),
    const Meal(name: 'Dinner'),
  ];

  static final _products = <Product>[
    Product(name: 'Banana', kcal: 99, protein: 1.2, fat: 0.3, carb: 22.5),
    Product(
      name: 'Impact WHEY protein natural chocolate (KFD)',
      kcal: 380,
      protein: 85,
      fat: 6,
      carb: 3,
    ),
  ];
}
