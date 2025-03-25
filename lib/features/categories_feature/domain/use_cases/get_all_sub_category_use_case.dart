import 'package:dartz/dartz.dart';
import 'package:graduation_project/features/categories_feature/data/models/category_model.dart';
import 'package:graduation_project/features/categories_feature/data/models/sub_category_model.dart';
import 'package:graduation_project/features/categories_feature/domain/repo/category_repo.dart';

import '../../../../../app/error/failures.dart';
import '../../../../../app/usecase/usecase.dart';

class GetAllSubCategoriesUseCase implements UseCase<List<SubCategoryModel>,GetAllSubCategoriesUseCaseParams >{
  final CategoryRepo categoryRepo;

  GetAllSubCategoriesUseCase({required this.categoryRepo});
  @override
  Future<Either<Failure, List<SubCategoryModel>>> call(GetAllSubCategoriesUseCaseParams params) {
    return categoryRepo.getSubCategories(params.toJson());
  }

}


class GetAllSubCategoriesUseCaseParams{
 final String categoryId;

  GetAllSubCategoriesUseCaseParams({required this.categoryId});

 Map<String, String> toJson() {
   final map = <String, String>{};
   map['id'] = categoryId;
   return map;
 }
}