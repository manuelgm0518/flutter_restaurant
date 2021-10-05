import 'package:flutter/material.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/models/FoodType.dart';
import 'package:flutter_restaurant/providers/food_types_provider.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';

class FoodTypeList extends StatefulWidget {
  FoodTypeList(this.slugs, {Key? key, this.scrollable = false, this.backgroundColor = kSecondaryColor, this.textColor = Colors.white, this.small = false}) : super(key: key);
  final List<String> slugs;
  final bool scrollable;
  final bool small;
  final Color backgroundColor;
  final Color textColor;

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

  Widget _foodTypeChip(FoodType foodType) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.small ? kSpacing2 : kSpacing3, vertical: widget.small ? kSpacing1 : kSpacing2),
      decoration: BoxDecoration(color: widget.backgroundColor, borderRadius: kRoundedBorder),
      //alignment: Alignment.center,
      child: Text(foodType.name, style: (widget.small ? Get.textTheme.caption : Get.textTheme.bodyText2)?.copyWith(color: widget.textColor)),
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator().centered()
        : widget.scrollable
            ? ListView.builder(
                padding: kPaddingX5,
                scrollDirection: Axis.horizontal,
                itemCount: foodTypeList.length,
                physics: kBouncyScroll,
                itemBuilder: (context, index) {
                  final foodType = foodTypeList[index];
                  return _foodTypeChip(foodType).px1;
                }).height(30)
            : Wrap(
                children: foodTypeList.map((e) => _foodTypeChip(e)).toList(),
                spacing: kSpacing,
                runSpacing: kSpacing2,
              );
  }
}
