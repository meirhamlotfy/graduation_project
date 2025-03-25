import 'package:dartz/dartz.dart';

import '../../../../../app/error/failures.dart';
import '../../../../../app/usecase/usecase.dart';
import '../../../data/models/user_model.dart';
import '../../repo/auth_repo.dart';

class GetAllEngUseCase implements UseCase<List<UserModel>,NoParams >{
  final AuthRepo farmerRepo;

  GetAllEngUseCase({required this.farmerRepo});
  @override
  Future<Either<Failure, List<UserModel>>> call(NoParams params) {
    return farmerRepo.gatAllEngineers();
  }

}
