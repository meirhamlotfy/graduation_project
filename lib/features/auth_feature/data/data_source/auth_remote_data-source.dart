import 'package:graduation_project/app/network/network_manager.dart';
import 'package:graduation_project/app/utils/hanlders/remote_data_source_handler.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource{
  Future<UserModel> farmerLogin(Map <String,String > map );
  Future<UserModel> farmerRegister(Map <String,String > map );
  Future<List<UserModel>> gatAllFarmers();
  Future<List<UserModel>> gatAllEngineers();
  Future<UserModel> engineerLogin(Map <String,String > map );
  Future<UserModel> engineerRegister(Map <String,String > map );
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  final NetworkManager networkManager;
  AuthRemoteDataSourceImpl({required this.networkManager});
  @override
  Future<List<UserModel>> gatAllFarmers() async {
    final response = await networkManager.request(
        endPoint: 'user',
        method: RequestMethod.get
    );
    final data = await RemoteDataSourceCallHandler()(response);
    return (data as List).map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  Future<UserModel> farmerLogin(Map<String, String> map) async {
    final response = await networkManager.request(
        endPoint: 'signin',
        body: map
    );
    final data = await RemoteDataSourceCallHandler()(response);
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel> farmerRegister(Map<String, String> map) async {
    final response = await networkManager.request(
        endPoint: 'new-user',
        body: map
    );
    final data = await RemoteDataSourceCallHandler()(response);
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel> engineerLogin(Map<String, String> map) async {
    final response = await networkManager.request(
        endPoint: 'login-eng',
        body: map
    );
    final data = await RemoteDataSourceCallHandler()(response);
    return UserModel.fromJson(data);
  }

    @override
  Future<UserModel> engineerRegister(Map<String, String> map)async {
      final response = await networkManager.request(
          endPoint: 'new-engineer',
          body: map
      );
      final data = await RemoteDataSourceCallHandler()(response);
      return UserModel.fromJson(data);
    }

  @override
  Future<List<UserModel>> gatAllEngineers() async {
    final response = await networkManager.request(
        endPoint: 'eng',
        method: RequestMethod.get
    );
    final data = await RemoteDataSourceCallHandler()(response);
    return (data as List).map((e) => UserModel.fromJson(e)).toList();
  }
}