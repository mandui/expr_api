class Property {
  var city = "济南";
  var district = "历下区";
  var street = "舜华路";
  var streetNo = "1269";
  var community = "得安大厦";
  var unit;
  var building;
  var room = "309";

  Map<String, dynamic> toJsonMap() {
    final map = Map<String, dynamic>();
    map['city'] = city;
    map['district'] = district;
    map['street'] = street;
    map['streetNo'] = streetNo;
    map['community'] = community;
    map['unit'] = unit;
    map['building'] = building;
    map['room'] = room;

    return map;
  }
}