import 'package:dartz/dartz.dart';
import 'package:graduation_project/features/categories_feature/data/models/category_model.dart';
import 'package:graduation_project/features/categories_feature/data/models/sub_category_model.dart';

import '../../../../app/error/failures.dart';

abstract class CategoryRepo{
  Future<Either<Failure, List<CategoryModel>>> getAllCategories();
  Future<Either<Failure, List<SubCategoryModel>>> getSubCategories(Map<String, String> map);

}