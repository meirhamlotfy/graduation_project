import 'package:dartz/dartz.dart';

import '../../../../../app/error/failures.dart';
import '../../../../../app/usecase/usecase.dart';
import '../../../data/models/user_model.dart';
import '../../repo/auth_repo.dart';

class FarmerLoginUseCase implements UseCase<UserModel,FarmerLoginParams >{
  final AuthRepo farmerRepo;

  FarmerLoginUseCase({required this.farmerRepo});
  @override
  Future<Either<Failure, UserModel>> call(FarmerLoginParams params) {
    return farmerRepo.farmerLogin(params.toJson());
  }

}

class FarmerLoginParams{
final String email;
final String password;
FarmerLoginParams({required this.email,required this.password});

  Map<String, String> toJson() {
    final map = <String, String>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}