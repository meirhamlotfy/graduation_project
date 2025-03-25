import 'package:dartz/dartz.dart';
import 'package:graduation_project/features/categories_feature/data/models/category_model.dart';
import 'package:graduation_project/features/categories_feature/domain/repo/category_repo.dart';

import '../../../../../app/error/failures.dart';
import '../../../../../app/usecase/usecase.dart';

class GetAllCategoriesUseCase implements UseCase<List<CategoryModel>,NoParams >{
  final CategoryRepo categoryRepo;

  GetAllCategoriesUseCase({required this.categoryRepo});
  @override
  Future<Either<Failure, List<CategoryModel>>> call(NoParams params) {
    return categoryRepo.getAllCategories();
  }

}
