import 'package:dartz/dartz.dart';
import '../../../../app/error/failures.dart';
import '../../../../app/usecase/usecase.dart';
import '../../data/models/stripe_models/ephemeral_keys_model/ephemeral_keys_Model.dart';
import '../repo/payment_repo.dart';

class EphemeralKeyUseCase implements UseCase<EphemeralKeysModel , EphemeralKeyUseCaseParams>{
  final PaymentRepo paymentRepo ;

  EphemeralKeyUseCase({required this.paymentRepo});
  @override
  Future<Either<Failure, EphemeralKeysModel>> call(params) async {
    return await paymentRepo.getEphemeralKey(params.toMap());
  }

}

class EphemeralKeyUseCaseParams{
  final String customerId;

  EphemeralKeyUseCaseParams(
      {
        required this.customerId,
      });

  Map<String, dynamic> toMap() {
    final map = {
      "customer" : customerId,
    };
    return map;
  }
}