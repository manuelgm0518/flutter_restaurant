import 'package:flutter/material.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key, required this.body, this.footer}) : super(key: key);

  final Widget body;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      ConditionalWrapper(
        condition: footer != null,
        conditionalBuilder: (child) => child.pb3,
        child: Card(child: body).rounded(kRoundedBorder),
      ),
      if (footer != null) footer!.aligned(Alignment.bottomCenter),
    ]);
  }
}
