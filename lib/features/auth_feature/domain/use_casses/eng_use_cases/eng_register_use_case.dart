import 'package:dartz/dartz.dart';

import '../../../../../app/error/failures.dart';
import '../../../../../app/usecase/usecase.dart';
import '../../../data/models/user_model.dart';
import '../../repo/auth_repo.dart';

class EngRegisterUseCase implements UseCase<UserModel,EngRegisterParams >{
  final AuthRepo farmerRepo;

  EngRegisterUseCase({required this.farmerRepo});
  @override
  Future<Either<Failure, UserModel>> call(EngRegisterParams params) {
    return farmerRepo.engineerRegister(params.toJson());
  }

}
/*
    "department":"specialist in plant",
    "payment_amount":55,
    "national_id":"30208161300084",
    "rating":2
 */
class EngRegisterParams{
  final String email;
  final String password;
  final String department;
  final String payment_amount;
  final String national_id;
  final String name;
  final String phone;
  final String governorate;
  final String rating;
  final String city;
  EngRegisterParams({
    required this.email,
    required this.department,
    required this.rating,
    required this.national_id,
    required this.payment_amount,
    required this.password,required this.name,required this.phone,required this.governorate,required this.city});

  Map<String, String> toJson() {
    final map = <String, String>{};
    map['email'] = email;
    map['password'] = password;
    map['department'] = department;
    map['rating'] = rating;
    map['national_id'] = national_id;
    map['payment_amount'] = payment_amount;
    map['name'] = name;
    map['phone'] = phone;
    map['governorate'] = governorate;
    map['city'] = city;
    return map;
  }
}