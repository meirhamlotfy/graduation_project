class SubCategoryModel {
  SubCategoryModel({
      this.id, 
      this.name, 
      this.about, 
      this.benifits, 
      this.catId, 
      this.vits, 
      this.image, 
      this.v,});

  SubCategoryModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    about = json['about'];
    benifits = json['benifits'];
    catId = json['cat_id'];
    vits = json['vits'];
    image = json['image'];
    v = json['__v'];
  }
  num? id;
  String? name;
  String? about;
  String? benifits;
  num? catId;
  String? vits;
  String? image;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['about'] = about;
    map['benifits'] = benifits;
    map['cat_id'] = catId;
    map['vits'] = vits;
    map['image'] = image;
    map['__v'] = v;
    return map;
  }

}