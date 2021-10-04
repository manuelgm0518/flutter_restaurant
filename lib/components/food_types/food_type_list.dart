import 'package:flutter/material.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/models/FoodType.dart';
import 'package:flutter_restaurant/providers/food_types_provider.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';

class FoodTypeList extends StatefulWidget {
  FoodTypeList(this.slugs, {Key? key}) : super(key: key);
  final List<String> slugs;

  @override
  _FoodTypeListState createState() => _FoodTypeListState();
}

class _FoodTypeListState extends State<FoodTypeList> {
  List<FoodType> foodTypeList = [];
  bool loading = true;

  Future<void> fetchData() async {
    setState(() => loading = true);
    foodTypeList.clear();
    final res = await FoodTypesProvider.to.getFoodTypes();
    if (res.isOk)
      res.body!.forEach((element) {
        if (widget.slugs.contains(element.slug)) foodTypeList.add(element);
      });
    setState(() => loading = false);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator().centered()
        : ListView.builder(
            padding: kPaddingX5,
            scrollDirection: Axis.horizontal,
            itemCount: foodTypeList.length,
            physics: kBouncyScroll,
            itemBuilder: (context, index) {
              final foodType = foodTypeList[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: kSpacing3, vertical: kSpacing2),
                decoration: BoxDecoration(color: kSecondaryColor, borderRadius: kRoundedBorder),
                alignment: Alignment.center,
                child: Text(foodType.name, style: Get.textTheme.bodyText2?.copyWith(color: Colors.white)),
              ).px1;
            }).height(30);

    // : foodTypeList.isEmpty
    //     ? Text('No hay resultados', style: Get.textTheme.bodyText2?.copyWith(color: kDarkColor), textAlign: TextAlign.center).left([
    //         IconButton(
    //           icon: Icon(UniconsLine.sync_icon),
    //           color: kDarkColor,
    //           onPressed: () => fetchData(),
    //         ),
    //       ]).centered()
    // : Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     //mainAxisSize: MainAxisSize.min,
    //     children: foodTypeList.map(
    //       (foodType) {
    //         return Container(
    //           padding: const EdgeInsets.symmetric(horizontal: kSpacing3, vertical: kSpacing2),
    //           decoration: BoxDecoration(
    //             color: kSecondaryColor,
    //             //border: Border.all(width: 2, color: kSecondaryColor.variants.light),
    //             borderRadius: kRoundedBorder,
    //           ),
    //           alignment: Alignment.center,
    //           child: Text(foodType.name, style: Get.textTheme.bodyText2?.copyWith(color: Colors.white)),
    //         ).pr3;
    //       },
    //     ).toList(),
    //   ).scrollable(padding: kPaddingX5);
  }
}
