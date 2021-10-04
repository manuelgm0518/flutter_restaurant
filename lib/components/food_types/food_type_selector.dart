import 'package:flutter/material.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/models/FoodType.dart';
import 'package:flutter_restaurant/providers/food_types_provider.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';

class FoodTypeSelector extends StatefulWidget {
  FoodTypeSelector({Key? key, this.selectedTypes = const {}, this.direction = Axis.horizontal}) : super(key: key);
  final Set<String> selectedTypes;
  final Axis direction;

  @override
  FoodTypeSelectorState createState() => FoodTypeSelectorState();
}

class FoodTypeSelectorState extends State<FoodTypeSelector> {
  bool _loading = false;
  final foodTypes = <FoodType>{};
  final selectedTypes = <String>{};

  Future<void> fetchData() async {
    setState(() => _loading = true);
    final res = await FoodTypesProvider.to.getFoodTypes();
    if (res.isOk) foodTypes.assignAll(res.body!);
    setState(() => _loading = false);
  }

  @override
  void initState() {
    selectedTypes.addAll(widget.selectedTypes);
    fetchData();
    super.initState();
  }

  Widget _foodTypeChip(FoodType foodType) {
    final selected = selectedTypes.contains(foodType.slug!);
    return Container(
      decoration: BoxDecoration(color: selected ? kSecondaryColor : kSecondaryColor.variants.light, borderRadius: kRoundedBorder),
      padding: const EdgeInsets.symmetric(horizontal: kSpacing3, vertical: kSpacing2),
      child: Text(
        foodType.name,
        style: Get.textTheme.bodyText1?.copyWith(color: selected ? Colors.white : kSecondaryColor, fontWeight: selected ? FontWeight.bold : FontWeight.normal),
      ),
    ).mouse(() {
      setState(() {
        selected ? selectedTypes.remove(foodType.slug!) : selectedTypes.add(foodType.slug!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator().centered()
        : Wrap(
            direction: widget.direction,
            spacing: kSpacing3,
            runSpacing: kSpacing2,
            children: foodTypes.map((element) {
              return _foodTypeChip(element);
            }).toList(),
          );
  }
}




// enum _FoodTypeSelectorStatus {
//   LOADING,
//   IDLE,
//   ERROR,
// }

// class FoodTypeSelector extends StatefulWidget {
//   FoodTypeSelector({Key? key, this.selectedTypes = const {}}) : super(key: key);
//   final Set<FoodType> selectedTypes;

//   @override
//   FoodTypeSelectorState createState() => FoodTypeSelectorState();
// }

// class FoodTypeSelectorState extends State<FoodTypeSelector> {
//   var _status = _FoodTypeSelectorStatus.LOADING;
//   final foodTypeField = TextEditingController();
//   final Set<FoodType> selectedFoodTypes = {};
//   List<FoodType> availableFoodTypes = [];

//   bool get _loading => _status == _FoodTypeSelectorStatus.LOADING;
//   bool _canAddFoodType = false;

//   @override
//   void initState() {
//     fetchFoodTypes();
//     super.initState();
//   }

//   Future<void> fetchFoodTypes() async {
//     setState(() => _status = _FoodTypeSelectorStatus.LOADING);
//     final res = await FoodTypesProvider.to.getFoodTypes();
//     if (res.hasError) {
//       setState(() => _status = _FoodTypeSelectorStatus.ERROR);
//       Printer.error(res.statusText, res.statusCode);
//     } else {
//       availableFoodTypes = res.body!;
//       setState(() => _status = _FoodTypeSelectorStatus.IDLE);
//     }
//   }

//   void addFoodType(String foodType) {
//     selectedFoodTypes.add(new FoodType(name: foodTypeField.text));
//     foodTypeField.clear();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: kPadding,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: kRoundedBorder,
//       ),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
//         TextField(
//           controller: foodTypeField,
//           decoration: InputDecoration(
//             suffixIcon: _loading
//                 ? const CircularProgressIndicator()
//                 : _canAddFoodType
//                     ? IconButton(
//                         icon: Icon(UniconsLine.pizza_slice),
//                         onPressed: () {},
//                       )
//                     : null,
//           ),
//         ),
//         Wrap(),
//       ]),
//     );
//   }
// }
