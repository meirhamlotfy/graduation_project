import 'package:dartz/dartz.dart';
import 'package:graduation_project/features/auth_feature/data/models/user_model.dart';

import '../../../../app/error/failures.dart';

abstract class AuthRepo{
  Future<Either<Failure, UserModel>> farmerLogin(Map <String,String > map );
  Future<Either<Failure, UserModel>> farmerRegister(Map <String,String > map );
  Future<Either<Failure, List<UserModel>>> gatAllFarmers();
  Future<Either<Failure, List<UserModel>>> gatAllEngineers();
  Future<Either<Failure, UserModel>> engineerLogin(Map <String,String > map );
  Future<Either<Failure, UserModel>> engineerRegister(Map <String,String > map );
}