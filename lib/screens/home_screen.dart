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
                aspectRation: 0.65,
                spacing: 30,
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      shadowColor: Colors.black54,
      child: Column(
        children: [
          Expanded(
              child: ClipOval(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image(
                image: AssetImage(meal.image),
                fit: BoxFit.cover,
              ),
            ),
          )),
          const SizedBox(
            height: 10,
          ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    5,
                    (index) => Icon(
                          index < 4 ? Icons.star : Icons.star_border,
                          color: Colors.yellow,
                        )),
              )
            ],
          ))
        ],
      ),
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
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final itemHeight = (width * 0.5) / aspectRation;
      final height = constraints.maxHeight + itemHeight;

      return OverflowBox(
        maxHeight: height,
        minHeight: height,
        maxWidth: width,
        minWidth: width,
        child: GridView.builder(
            padding: EdgeInsets.only(top: itemHeight * 0.5, bottom: itemHeight),
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: aspectRation,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing),
            itemBuilder: (context, index) {
              return Transform.translate(
                offset: Offset(0.0, index.isOdd ? (itemHeight * 0.5) : 0.0),
                child: itemBuilder(context, index),
              );
            }),
      );
    });
  }
}
