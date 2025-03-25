import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:graduation_project/app/error/exceptions.dart';

import 'package:graduation_project/app/error/failures.dart';
import 'package:graduation_project/app/network/network_info.dart';
import 'package:graduation_project/app/services/cache_service.dart';
import 'package:graduation_project/app/utils/hanlders/repo_impl_callhandler.dart';

import 'package:graduation_project/features/auth_feature/data/models/user_model.dart';

import '../../../../app/utils/get_it_injection.dart';
import '../../domain/repo/auth_repo.dart';
import '../data_source/auth_remote_data-source.dart';

class FarmerRepoImpl extends AuthRepo{
  final AuthRemoteDataSource farmerRemoteDataSource;
  final NetworkInfo networkInfo;
  FarmerRepoImpl({required this.farmerRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, UserModel>> farmerLogin(Map<String, String> map) async{
    return await RepoImplCallHandler<UserModel>(networkInfo)(() async {
      final response = await farmerRemoteDataSource.farmerLogin(map);
      await getIt<CacheService>().setUserToken(token: response.token??"null");
      await getIt<CacheService>().saveUserData(encodedUser: json.encode(response.toJson()));
      return response;
    });
  }

  @override
  Future<Either<Failure, UserModel>> farmerRegister(Map<String, String> map)  async{
    return await RepoImplCallHandler<UserModel>(networkInfo)(() async {
      final response = await farmerRemoteDataSource.farmerRegister(map);
      await getIt<CacheService>().setUserToken(token: response.token??"null");
      await getIt<CacheService>().saveUserData(encodedUser: json.encode(response.toJson()));
      return response;
    });
  }

  @override
  Future<Either<Failure, List<UserModel>>> gatAllFarmers()  async{
    return await RepoImplCallHandler<List<UserModel>>(networkInfo)(() async {
      final response = await farmerRemoteDataSource.gatAllFarmers();
      return response;
    });
  }

  @override
  Future<Either<Failure, UserModel>> engineerLogin(Map<String, String> map)  async{
    return await RepoImplCallHandler<UserModel>(networkInfo)(() async {
      final response = await farmerRemoteDataSource.engineerLogin(map);
      await getIt<CacheService>().setUserToken(token: response.token??"null");
      await getIt<CacheService>().saveUserData(encodedUser: json.encode(response.toJson()));
      return response;
    });
  }

  @override
  Future<Either<Failure, UserModel>> engineerRegister(Map<String, String> map)   async{
    return await RepoImplCallHandler<UserModel>(networkInfo)(() async {
      final response = await farmerRemoteDataSource.engineerRegister(map);
      await getIt<CacheService>().setUserToken(token: response.token??"null");
      await getIt<CacheService>().saveUserData(encodedUser: json.encode(response.toJson()));
      return response;
    });
  }

  @override
  Future<Either<Failure, List<UserModel>>> gatAllEngineers()async{
    return await RepoImplCallHandler<List<UserModel>>(networkInfo)(() async {
      final response = await farmerRemoteDataSource.gatAllEngineers();
      return response;
    });
  }
}