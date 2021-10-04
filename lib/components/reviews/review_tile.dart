import 'package:flutter/material.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/models/Review.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({Key? key, required this.review}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(review.email, style: Get.textTheme.bodyText1?.copyWith(color: kSecondaryColor)).pr.right([
          Icon(UniconsSolid.star, color: Colors.amber, size: 20).pr1,
          Text(review.rating.toString() + '.0', style: Get.textTheme.bodyText1?.copyWith(color: Colors.amber)),
        ]),
        if (review.comments != null) Text(review.comments!, style: Get.textTheme.bodyText2?.copyWith(color: Colors.black)),
        if (review.createdDate != null)
          Text(DateFormat('dd / MM / yy').format(review.createdDate!), style: Get.textTheme.caption?.copyWith(color: kDarkColor)).aligned(Alignment.bottomRight),
      ]),
    );
  }
}
