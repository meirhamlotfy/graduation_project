import 'dart:ui';

class UserModel {
  UserModel({
      this.id, 
      this.name, 
      this.phone, 
      this.password, 
      this.email, 
      this.governorate, 
      this.city, 
      this.department, 
      this.paymentAmount, 
      this.nationalId, 
      this.avatar, 
      this.token, 
      this.v,});

  UserModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    email = json['email'];
    governorate = json['governorate'];
    city = json['city'];
    department = json['department'];
    paymentAmount = json['payment_amount'];
    nationalId = json['national_id'];
    avatar = json['avatar'];
    token = json['token'];
    v = json['__v'];
  }
  int? id;
  String? name;
  String? phone;
  String? password;
  String? email;
  dynamic governorate;
  dynamic city;
  String? department;
  num? paymentAmount;
  String? nationalId;
  String? avatar;
  String? token;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['password'] = password;
    map['email'] = email;
    map['governorate'] = governorate;
    map['city'] = city;
    map['department'] = department;
    map['payment_amount'] = paymentAmount;
    map['national_id'] = nationalId;
    map['avatar'] = avatar;
    map['token'] = token;
    map['__v'] = v;
    return map;
  }

}