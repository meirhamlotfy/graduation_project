
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/app/usecase/usecase.dart';
import 'package:graduation_project/features/categories_feature/data/models/category_model.dart';
import 'package:graduation_project/features/categories_feature/data/models/sub_category_model.dart';
import 'package:graduation_project/features/categories_feature/domain/use_cases/get_all_categories_use_case.dart';
import 'package:graduation_project/features/categories_feature/domain/use_cases/get_all_sub_category_use_case.dart';

import '../../../../app/utils/get_it_injection.dart';
import '../../../../app/utils/hanlders/error_state_handler.dart';
import '../../../../app/utils/navigation_helper.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  static CategoryCubit get() => BlocProvider.of(getIt<NavHelper>().navigatorKey.currentState!.context);
  List<CategoryModel>? allCategories ;
  List<SubCategoryModel>? allSubCategories;

  void getAllCategories()async {
    emit(CategoryLoading());
    final res = await getIt<GetAllCategoriesUseCase>()(NoParams());
    res.fold(
        errorStateHandler,
        (r) {
          allCategories = r;
          print(allCategories?[0].name??"null");
        },
    );
    emit(CategoryInitial());
  }

  void getAllSubCategories({required String categoryId})async {
    emit(CategoryLoading());
    final res = await getIt<GetAllSubCategoriesUseCase>()(
        GetAllSubCategoriesUseCaseParams(
          categoryId:categoryId,
        ));
    res.fold(
        errorStateHandler,
        (r) {
          allSubCategories = r;
          print(allSubCategories?[0].name??"null");
        },
    );
    emit(CategoryInitial());
  }
}
