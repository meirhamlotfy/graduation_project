class CategoryModel {
  CategoryModel({
      this.id, 
      this.name, 
      this.avatar, 
      this.v,});

  CategoryModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    avatar = json['avatar'];
    v = json['__v'];
  }
  num? id;
  String? name;
  String? avatar;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['avatar'] = avatar;
    map['__v'] = v;
    return map;
  }

}