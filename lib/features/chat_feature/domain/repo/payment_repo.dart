import 'package:dartz/dartz.dart';
import '../../../../app/error/failures.dart';
import '../../data/models/stripe_models/create_customer_model/create_customer_model.dart';
import '../../data/models/stripe_models/ephemeral_keys_model/ephemeral_keys_Model.dart';
import '../../data/models/stripe_models/intent_output_model/intent_output_model.dart';

abstract  class PaymentRepo{
  Future<Either<Failure, IntentOutputModel>>createPaymentIntent(Map <String,dynamic > map );
  Future<Either<Failure, CreateCustomerModel>>createCustomer(Map <String,dynamic > map );
  Future<Either<Failure, EphemeralKeysModel>>getEphemeralKey(Map <String,dynamic > map );
}