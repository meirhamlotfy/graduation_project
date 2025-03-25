import 'package:graduation_project/features/categories_feature/data/models/sub_category_model.dart';

import '../../../../app/network/network_manager.dart';
import '../../../../app/utils/hanlders/remote_data_source_handler.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource{

  Future<List<CategoryModel>> getAllCategories();
  Future<List<SubCategoryModel>> getSubCategories(Map <String,String > map );
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource{
  final NetworkManager networkManager;

  CategoryRemoteDataSourceImpl({required this.networkManager});

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final response = await networkManager.request(
        endPoint: 'all-category',
        method: RequestMethod.get
    );
    final data = await RemoteDataSourceCallHandler()(response);
    return (data as List).map((e) => CategoryModel.fromJson(e)).toList();
  }

  @override
  Future<List<SubCategoryModel>> getSubCategories(Map <String,String > map )async {
    final response = await networkManager.request(
        endPoint: 'plants/${map['id']}',
        method: RequestMethod.get
    );
    final data = await RemoteDataSourceCallHandler()(response);
    return (data as List).map((e) => SubCategoryModel.fromJson(e)).toList();
  }

}