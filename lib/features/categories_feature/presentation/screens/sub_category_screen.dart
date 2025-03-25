import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/widgets/default_app_bar_widget.dart';
import 'package:graduation_project/app/widgets/loading.dart';

import '../../../../app/utils/app_assets.dart';
import '../../../../main.dart';
import '../../../home_feature/presentation/widgets/custom_home_item.dart';
import '../PLH/category_cubit.dart';

class SubCategoriesScreen extends StatefulWidget {
  const SubCategoriesScreen({super.key, required this.title, required this.categoryId});
  final String title ;
  final String categoryId ;
  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  @override
  void initState() {
    super.initState();
    CategoryCubit.get().getAllSubCategories(categoryId: widget.categoryId);
  }
  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBarWidget(
        title: widget.title,
        titleColor: AppColors.mainColor,
        centerTitle: true,
        canBack: true,
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
  builder: (context, state) {
    var cubit = CategoryCubit.get();
    return
      state is CategoryLoading?
      const Center(
        child:  Loading(),
      ):
      ListView.builder(
        itemCount: cubit.allSubCategories?.length ?? 0,
        padding: EdgeInsets.symmetric(horizontal:16.sp),
        // gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 16.w,
        //     crossAxisSpacing: 16.h
        // ),
        itemBuilder: (context, index) {
          return
            FlipCard(
            fill: Fill.fillBack,
            speed: 800,
            direction:index % 2 == 0 ? FlipDirection.VERTICAL : FlipDirection.HORIZONTAL, // default
            side: CardSide.FRONT,
            front: CustomSubCategoryItem(
              image: cubit.allSubCategories?[index].image ?? AppImages.frame,
              name:cubit.allSubCategories?[index].name ?? "" ,
              benefit:cubit.allSubCategories?[index].benifits ?? "" ,
            ),
            back: CustomSubCategoryBackItem(
              details:cubit.allSubCategories?[index].about ?? ""  ,
              vits:cubit.allSubCategories?[index].vits ?? ""  ,
            ),
          );
        },
      );
  },
),
    );
  }
}
