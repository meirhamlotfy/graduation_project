import 'package:dartz/dartz.dart';

import 'package:graduation_project/app/error/failures.dart';
import 'package:graduation_project/features/categories_feature/data/data_source/category_remote_data_source.dart';

import 'package:graduation_project/features/categories_feature/data/models/category_model.dart';

import 'package:graduation_project/features/categories_feature/data/models/sub_category_model.dart';

import '../../../../app/network/network_info.dart';
import '../../../../app/utils/hanlders/repo_impl_callhandler.dart';
import '../../../auth_feature/data/data_source/auth_remote_data-source.dart';
import '../../domain/repo/category_repo.dart';

class CategoryRepoImpl extends CategoryRepo {
  final CategoryRemoteDataSource categoryRemoteDataSource;
  final NetworkInfo networkInfo;

  CategoryRepoImpl({required this.categoryRemoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategories() async{
    return await RepoImplCallHandler<List<CategoryModel>>(networkInfo)(() async {
      final response = await categoryRemoteDataSource.getAllCategories();
      return response;
    });
  }

  @override
  Future<Either<Failure, List<SubCategoryModel>>> getSubCategories(Map<String, String> map)async{
    return await RepoImplCallHandler<List<SubCategoryModel>>(networkInfo)(() async {
      final response = await categoryRemoteDataSource.getSubCategories(map);
      return response;
    });
  }

}