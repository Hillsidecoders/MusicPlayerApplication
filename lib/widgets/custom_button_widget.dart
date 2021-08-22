import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:melophile/uitools/const.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomButtonWidget extends StatelessWidget {
  final double size;
  final Widget child;
  final String image;
  final double borderWidth;
  final bool isActive;
  final VoidCallback onTap;

  CustomButtonWidget({
    required this.child,
    required this.size,
    required this.onTap,
    this.borderWidth = 2,
    this.image = '',
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(200),
      ),
      border: Border.all(
        width: borderWidth,
        color: isActive ? AppColors.darkBlue : AppColors.mainColor,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.lightBlueShadow,
          blurRadius: 10,
          offset: Offset(5, 5),
          spreadRadius: 3,
        ),
        BoxShadow(
          color: Colors.white70,
          blurRadius: 5,
          offset: Offset(-5, -5),
          spreadRadius: 3,
        ),
      ],
    );
    if (image == 'default') {
      boxDecoration = boxDecoration.copyWith(
        image: DecorationImage(
          image: ExactAssetImage("assets/images/mainImg.jpg"),
          fit: BoxFit.cover,
        ),
      );
    } else if (image != '' && image != 'default') {
      boxDecoration = boxDecoration.copyWith(
        image: DecorationImage(
          image: CachedNetworkImageProvider(image),
          fit: BoxFit.cover,
        ),
      );
    }

    if (isActive) {
      boxDecoration = boxDecoration.copyWith(
        gradient: RadialGradient(
          colors: [
            AppColors.lightBlue,
            AppColors.darkBlue,
          ],
        ),
      );
    } else {
      boxDecoration = boxDecoration.copyWith(
        gradient: RadialGradient(
          colors: [
            AppColors.mainColor,
            AppColors.mainColor,
            AppColors.mainColor,
            Colors.white,
          ],
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: boxDecoration,
      child: TextButton(
        onPressed: onTap,
        child: child,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(200),
            ),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.all(0)),
        ),
      ),
    );
  }
}
