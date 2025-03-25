import 'package:dartz/dartz.dart';


import '../../../../app/error/failures.dart';
import '../../../../app/usecase/usecase.dart';
import '../../data/models/stripe_models/create_customer_model/create_customer_model.dart';
import '../repo/payment_repo.dart';

class CreateCustomerUseCase implements UseCase<CreateCustomerModel , CreateCustomerUseCaseParams>{
  final PaymentRepo paymentRepo ;

  CreateCustomerUseCase({required this.paymentRepo});
  @override
  Future<Either<Failure, CreateCustomerModel>> call(params) async {
    return await paymentRepo.createCustomer(params.toMap());
  }

}


class CreateCustomerUseCaseParams{
  final String? name;
  final String ?email;
  final String ?phone;

  CreateCustomerUseCaseParams(
      {
         this.name,
         this.phone,
         this.email,
      });

  Map<String, dynamic> toMap() {
    final map = {
      "email" : email,
      "phone" : phone,
      "name"  : name,
    };
    return map;
  }
}