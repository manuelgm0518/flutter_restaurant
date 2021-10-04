import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/config/app_themes.dart';
import 'package:flutter_restaurant/utils/ui_utils.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(this.url, {Key? key, this.placeholder, this.width, this.height, this.borderRadius, this.placeholderColor}) : super(key: key);

  final String? url;
  final Widget? placeholder;
  final double? width;
  final double? height;
  final Color? placeholderColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final _placeholder = DefaultPlaceholder(width: width, height: height, color: placeholderColor);
    return ((url?.isURL ?? false)
            ? CachedNetworkImage(
                imageUrl: url!,
                placeholder: (context, url) => placeholder ?? _placeholder,
                errorWidget: (context, url, error) => placeholder ?? _placeholder,
                fit: BoxFit.cover,
                width: width,
                height: height,
              )
            : _placeholder)
        .rounded(borderRadius);
  }
}

class DefaultPlaceholder extends StatelessWidget {
  const DefaultPlaceholder({Key? key, this.width, this.height, this.color}) : super(key: key);
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? kLightColor,
      alignment: Alignment.center,
      width: width,
      height: height,
      child: Icon(
        UniconsLine.pizza_slice,
        color: (color ?? kLightColor).variants.dark.withOpacity(0.25),
        size: 50,
      ),
    );
  }
}
