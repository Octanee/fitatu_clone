import 'package:animate_icons/animate_icons.dart';
import 'package:fitatu_clone/common.dart';
import 'package:fitatu_clone/extensions.dart';
import 'package:fitatu_clone/fake_api.dart';
import 'package:fitatu_clone/models/models.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: Column(
        children: const [
          _WeekBar(),
          _ContentList(),
          _CaloriesBar(),
        ],
      ),
    );
  }
}

class _ContentList extends StatelessWidget {
  const _ContentList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: FakeApi.meals
            .map<Widget>(
              (meal) => _MealItem(
                meal: meal,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _MealItem extends StatefulWidget {
  const _MealItem({required this.meal});

  final Meal meal;

  @override
  State<_MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<_MealItem>
    with SingleTickerProviderStateMixin {
  bool isExpand = false;

  final _expandDuration = const Duration(milliseconds: 300);

  late AnimateIconController _iconController;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    _iconController = AnimateIconController();
    _expandController = AnimationController(
      vsync: this,
      duration: _expandDuration,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _getContent(),
              _options(),
              _add(),
            ],
          ),
        ),
        _products(),
      ],
    );
  }

  Widget _products() {
    return SizeTransition(
      sizeFactor: _expandAnimation,
      axisAlignment: 1,
      child: Column(
        children: widget.meal.products
            .map<Widget>((product) => _ProductItem(product: product))
            .toList(),
      ),
    );
  }

  Widget _add() {
    return const CircleButton(
      color: AppColors.green,
      size: 44,
      child: Icon(
        Icons.add_rounded,
        size: 32,
      ),
    );
  }

  Widget _options() {
    return const CircleButton(
      size: 44,
      child: Icon(
        Icons.drag_indicator,
        size: 44,
        color: AppColors.green,
      ),
    );
  }

  void _changeExpand() {
    setState(() {
      isExpand = !isExpand;
      if (isExpand) {
        _iconController.animateToStart();
        _expandController.forward();
      } else {
        _iconController.animateToEnd();
        _expandController.reverse();
      }
    });
  }

  Widget _getContent() {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: widget.meal.products.isNotEmpty ? _changeExpand : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(widget.meal.name, style: AppTextStyle.bold24),
                Visibility(
                  visible: widget.meal.products.isNotEmpty,
                  child: AnimateIcons(
                    controller: _iconController,
                    startIcon: Icons.arrow_drop_down_rounded,
                    endIcon: Icons.arrow_drop_up_rounded,
                    onEndIconPress: () {
                      _changeExpand();
                      return true;
                    },
                    onStartIconPress: () {
                      _changeExpand();
                      return true;
                    },
                    startIconColor: AppColors.white,
                    endIconColor: AppColors.white,
                    size: 24,
                    duration: _expandDuration,
                  ),
                )
              ],
            ),
            _MacronutrientsRow(
              kcal: widget.meal.kcal,
              protein: widget.meal.protein,
              fat: widget.meal.fat,
              carb: widget.meal.carb,
              textStyle:
                  AppTextStyle.regular16.copyWith(color: AppColors.lightGrey),
              onlyKcal: widget.meal.products.isEmpty,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 1),
      child: DecoratedBox(
        decoration: const BoxDecoration(color: AppColors.lightGrey),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _content(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.cancel_outlined,
                color: AppColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: AppTextStyle.medium20,
            ),
            const SizedBox(height: 4),
            _MacronutrientsRow(
              kcal: product.kcal,
              protein: product.protein,
              fat: product.fat,
              carb: product.carb,
              textStyle: AppTextStyle.regular16,
            ),
          ],
        ),
      ),
    );
  }
}

class _MacronutrientsRow extends StatelessWidget {
  const _MacronutrientsRow({
    this.kcal = 0,
    this.protein = 0,
    this.fat = 0,
    this.carb = 0,
    this.textStyle,
    this.onlyKcal = false,
  });

  final double kcal;
  final double protein;
  final double fat;
  final double carb;
  final TextStyle? textStyle;
  final bool onlyKcal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Text(
            '${kcal.toStringAsFixed(0)} kcal',
            style: textStyle,
          ),
        ),
        const SizedBox(width: 64),
        Visibility(
          visible: !onlyKcal,
          child: Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    protein.toString(),
                    style: textStyle,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    fat.toString(),
                    style: textStyle,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    carb.toString(),
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WeekBar extends StatelessWidget {
  const _WeekBar();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8, top: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'fitatu',
              style: AppTextStyle.bold28.copyWith(color: AppColors.darkGrey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                7,
                (index) => _WeekItem(
                  day: DateTime.now()
                      .subtract(const Duration(days: 3))
                      .add(Duration(days: index))
                      .toDay(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeekItem extends StatelessWidget {
  const _WeekItem({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context) {
    const size = 40.0;

    final isToday = day == DateTime.now().toDay();

    final textColor = isToday ? AppColors.white : AppColors.darkGrey;
    final circleColor = isToday ? AppColors.darkGrey : Colors.transparent;

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        color: circleColor,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              day.dayLetter,
              style: AppTextStyle.semiBold16.copyWith(color: textColor),
            ),
            Text(
              day.day.toString(),
              style: AppTextStyle.medium16.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _CaloriesBar extends StatelessWidget {
  const _CaloriesBar();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            _kcalItem(),
            _proteinItem(),
            _fatItem(),
            _carbItem(),
          ],
        ),
      ),
    );
  }

  Widget _kcalItem() {
    return const _CaloriesBarItem(
      name: 'Kcal',
      maxValue: 2500,
      value: 1463,
      suffix: 'kcal',
      indicatorColor: Colors.purple,
    );
  }

  Widget _proteinItem() {
    return const _CaloriesBarItem(
      name: 'Prot.',
      maxValue: 160,
      value: 124,
      suffix: 'kcal',
      indicatorColor: Colors.blue,
    );
  }

  Widget _fatItem() {
    return const _CaloriesBarItem(
      name: 'Fat',
      maxValue: 85,
      value: 43,
      suffix: 'kcal',
      indicatorColor: Colors.yellow,
    );
  }

  Widget _carbItem() {
    return const _CaloriesBarItem(
      name: 'Carb.',
      maxValue: 280,
      value: 210,
      suffix: 'kcal',
      indicatorColor: Colors.pink,
    );
  }
}

class _CaloriesBarItem extends StatelessWidget {
  const _CaloriesBarItem({
    required this.name,
    required this.maxValue,
    this.value = 0,
    this.suffix = 'g',
    required this.indicatorColor,
  });

  final double value;
  final double maxValue;
  final String name;
  final String suffix;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 4,
          left: 4,
          right: 4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: LinearPercentIndicator(
                progressColor: indicatorColor,
                padding: EdgeInsets.zero,
                barRadius: const Radius.circular(8),
                backgroundColor: AppColors.darkGrey,
                lineHeight: 8,
                percent: value / maxValue,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                Text(
                  name,
                  style: AppTextStyle.semiBold14,
                ),
                const SizedBox(width: 2),
                Text(value.toString(), style: AppTextStyle.bold16),
              ],
            ),
            Text(
              '/${maxValue.toStringAsFixed(0)} $suffix',
              style: AppTextStyle.regular12,
            ),
          ],
        ),
      ),
    );
  }
}
