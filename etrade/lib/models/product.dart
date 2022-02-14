class Product {
  int? _id;
  String? _name;
  String? _description;
  double? _price;

  //Default Construction
  Product(this._name, this._description, this._price);
  //Update Construction
  Product.withId(this._id, this._name, this._description, this._price);

  //Getter ve Setter

  //Getters
  int get id => _id!;
  String get name => _name!;
  String get description => _description!;
  double get price => _price!;

  //Setters
  set name(String value) {
    if (value.length > 2) {
      _name = value;
    }
  }

  set description(String value) {
    if (value.length >= 10) {
      _description = value;
    }
  }

  set price(double value) {
    if (value > 0) {
      _price = value;
    }
  }

//Elimizdeki nesneyi mape çevirmek için
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["description"] = _description;
    map["price"] = _price;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

//From object yapısı
  Product.fromObject(dynamic o) {
    _id = o["Id"];
    _name = o["Name"];
    _description = o["Description"];
    _price = double.tryParse(o["Price"].toString());
  }
}