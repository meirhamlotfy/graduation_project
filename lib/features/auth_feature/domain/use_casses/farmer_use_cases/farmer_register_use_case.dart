import 'package:dartz/dartz.dart';

import '../../../../../app/error/failures.dart';
import '../../../../../app/usecase/usecase.dart';
import '../../../data/models/user_model.dart';
import '../../repo/auth_repo.dart';

class FarmerRegisterUseCase implements UseCase<UserModel,FarmerRegisterParams >{
  final AuthRepo farmerRepo;

  FarmerRegisterUseCase({required this.farmerRepo});
  @override
  Future<Either<Failure, UserModel>> call(FarmerRegisterParams params) {
    return farmerRepo.farmerRegister(params.toJson());
  }

}
/*
    "name":"Mohamed",
    "password":"MohKh@123",
    "email":"mohamedkhalidshawky@gmail.com",
    "phone":"01016738849",//regular expression egypt ,,,,, add min length for numbers,,handel 0
    "governorate":"cairo",
    "city":"Mansoura"
 */
class FarmerRegisterParams{
  final String email;
  final String password;
  final String name;
  final String phone;
  final String governorate;
  final String city;
  FarmerRegisterParams({
    required this.email,required this.password,required this.name,required this.phone,required this.governorate,required this.city});

  Map<String, String> toJson() {
    final map = <String, String>{};
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    map['phone'] = phone;
    map['governorate'] = governorate;
    map['city'] = city;
    return map;
  }
}