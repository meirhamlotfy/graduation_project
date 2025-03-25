import 'package:dartz/dartz.dart';

import '../../../../../app/error/failures.dart';
import '../../../../../app/usecase/usecase.dart';
import '../../../data/models/user_model.dart';
import '../../repo/auth_repo.dart';

class EngLoginUseCase implements UseCase<UserModel,EngLoginParams >{
  final AuthRepo farmerRepo;

  EngLoginUseCase({required this.farmerRepo});
  @override
  Future<Either<Failure, UserModel>> call(EngLoginParams params) {
    return farmerRepo.engineerLogin(params.toJson());
  }

}

class EngLoginParams{
  final String email;
  final String password;
  EngLoginParams({required this.email,required this.password});

  Map<String, String> toJson() {
    final map = <String, String>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}