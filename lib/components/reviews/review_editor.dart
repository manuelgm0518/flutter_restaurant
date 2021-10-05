import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_restaurant/components/custom/custom_button.dart';
import 'package:flutter_restaurant/components/custom/custom_text_field.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/models/Restaurant.dart';
import 'package:flutter_restaurant/models/Review.dart';
import 'package:flutter_restaurant/providers/reviews_provider.dart';
import 'package:flutter_restaurant/services/session_service.dart';
import 'package:flutter_restaurant/utils/printer.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class ReviewEditor extends StatefulWidget {
  ReviewEditor._({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant restaurant;

  static Future<Review?> show(Restaurant restaurant) async {
    return await Get.bottomSheet(
      ReviewEditor._(restaurant: restaurant),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(kBorderRadius))),
    );
  }

  @override
  _ReviewEditorState createState() => _ReviewEditorState();
}

class _ReviewEditorState extends State<ReviewEditor> {
  final commentsField = TextEditingController();
  final statusButtonKey = GlobalKey<CustomButtonState>();
  double rating = 5.0;

  void save() {
    statusButtonKey.currentState?.setStatus(CustomButtonStatus.LOADING);
    final review = new Review(
      restaurant: widget.restaurant.slug!,
      email: SessionService.to.userEmail!,
      comments: commentsField.text,
      rating: rating.toInt(),
    );
    ReviewsProvider.to.postReview(review).then((value) {
      Get.back(result: value.body);
    }, onError: (error) {
      Printer.error(error);
      statusButtonKey.currentState?.setStatus(CustomButtonStatus.IDLE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: [
      Container(width: 80, height: 5, color: kLightColor).rounded().py3.centered(),
      kSpacerY,
      Text.rich(
        TextSpan(text: 'Reseña de ', style: Get.textTheme.headline4?.copyWith(color: Colors.black), children: [
          TextSpan(
            text: widget.restaurant.name,
            style: Get.textTheme.headline4?.copyWith(color: kSecondaryColor),
          )
        ]),
      ).px5,
      kSpacerY4,
      RatingBar(
        initialRating: rating,
        direction: Axis.horizontal,
        itemCount: 5,
        glow: false,
        ratingWidget: RatingWidget(
          full: Icon(UniconsSolid.star, color: Colors.amber),
          half: Icon(UniconsSolid.star_half_alt, color: Colors.amber),
          empty: Icon(UniconsLine.star, color: Colors.amber),
        ),
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        onRatingUpdate: (rating) {
          this.rating = rating;
        },
      ).centered().px5,
      kSpacerY4,
      CustomTextField(
        label: 'Comentarios',
        prefix: Icon(UniconsLine.paragraph),
        controller: commentsField,
        textArea: true,
      ).px5,
      kSpacerY4,
      kDivider.pxy(5, 3),
      CustomButton.elevated(
        key: statusButtonKey,
        child: Text('Guardar'),
        prefix: Icon(UniconsLine.save),
        onPressed: () => save(),
      ).px5,
    ]).py4.keyboardScroll();
  }
}
