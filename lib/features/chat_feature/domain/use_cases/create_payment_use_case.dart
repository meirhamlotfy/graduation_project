import 'package:dartz/dartz.dart';


import '../../../../app/error/failures.dart';
import '../../../../app/usecase/usecase.dart';
import '../../data/models/stripe_models/intent_output_model/intent_output_model.dart';
import '../repo/payment_repo.dart';

class CreatePaymentIntentUseCase implements UseCase<IntentOutputModel , CreatePaymentIntentUseCaseParams>{
  final PaymentRepo paymentRepo ;

  CreatePaymentIntentUseCase({required this.paymentRepo});
  @override
  Future<Either<Failure, IntentOutputModel>> call(params) async {
    return await paymentRepo.createPaymentIntent(params.toMap());
  }

}
class CreatePaymentIntentUseCaseParams {
  final int amount;
  final String currency;
  final String customerId;

  CreatePaymentIntentUseCaseParams(
      {
        required this.amount,
        required this.currency,
        required this.customerId,
      });

  Map<String, dynamic> toMap() {
    final map = {
      "amount" : "${amount*100}".toString(),
      "currency" : currency,
      "customer" : customerId,
    };
    return map;
  }
}