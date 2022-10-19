import 'package:flutter/material.dart';
import 'package:staggered_dual_view/data/meal_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.light(),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Meals',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: StaggeredDualView(
                itemBuilder: (context, index) {
                  return MealItem(
                    meal: meals[index],
                  );
                },
                itemCount: meals.length)));
  }
}

class MealItem extends StatelessWidget {
  const MealItem({Key? key, required this.meal}) : super(key: key);

  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Image(
          image: AssetImage(meal.image),
          fit: BoxFit.cover,
        )),
        const Padding(padding: EdgeInsets.only(top: 20.0)),
        Expanded(
            child: Column(
          children: [
            Text(
              meal.name,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              meal.weight,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                  color: Colors.grey),
            ),
          ],
        ))
      ],
    );
  }
}

class StaggeredDualView extends StatelessWidget {
  const StaggeredDualView(
      {Key? key,
      required this.itemBuilder,
      required this.itemCount,
      this.spacing = 0.0,
      this.aspectRation = 0.5})
      : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRation;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: aspectRation,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing),
        itemBuilder: itemBuilder);
  }
}
