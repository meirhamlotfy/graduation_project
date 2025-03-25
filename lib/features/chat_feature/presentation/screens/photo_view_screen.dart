
import 'package:flutter/material.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/widgets/default_app_bar_widget.dart';
import 'package:graduation_project/app/widgets/text_widget.dart';
import 'package:photo_view/photo_view.dart';


class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen(
      {super.key, required this.image,});
 final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: DefaultAppBarWidget(
        titleWidget:  TextWidget(
           title: image.substring(155,175),
           titleColor: AppColors.white,
         ),
        titleColor: AppColors.white,
        leadingColor: AppColors.white,
        backColor: AppColors.mainColor,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(image),
      )
    );
  }
}
