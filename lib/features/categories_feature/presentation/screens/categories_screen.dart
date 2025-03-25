import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/app/utils/app_colors.dart';
import 'package:graduation_project/app/widgets/default_app_bar_widget.dart';
import 'package:graduation_project/features/categories_feature/presentation/PLH/category_cubit.dart';
import 'package:graduation_project/features/categories_feature/presentation/screens/sub_category_screen.dart';
import '../../../../app/utils/app_assets.dart';
import '../../../../app/utils/helper.dart';
import '../../../../app/widgets/loading.dart';
import '../../../home_feature/presentation/widgets/custom_home_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    CategoryCubit.get().getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBarWidget(
        title: "الاقسام",
        titleColor: AppColors.mainColor,
        centerTitle: true,
        canBack: false,
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
            itemCount: cubit.allCategories?.length ?? 0,
            padding: EdgeInsets.all(16.sp),
            physics: const AlwaysScrollableScrollPhysics(),
            // gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 16.w,
            //     crossAxisSpacing: 16.h
            // ),
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    navigateTo(SubCategoriesScreen(
                        title:cubit.allCategories?[index].name??"",
                      categoryId: cubit.allCategories?[index].id.toString()??""
                    ),
                    );
                  },
                  child: CustomCategoryItem(
                    image: cubit.allCategories?[index].avatar??AppImages.frame,
                    name: cubit.allCategories?[index].name??"",
                  ));
            },
          );
        },
      ),
    );
  }
}
