class Property {
  final addrMap = Address().toJsonMap();
  final accountMap = Account().toJsonMap();
  final propInfo = PropertyInfo().toJsonMap();
  final ownerInfo = OwnerInfo().toJsonMap();

  Map<String, dynamic> toJsonMap() {
    final map = Map<String, dynamic>();
    map["prop_addr"] = addrMap;
    map["prop_account"] = accountMap;
    map["prop_Info"] = propInfo;
    map["owner_info"] = ownerInfo;

    return map;
  }
}

class PropertyList {
  Map<String, List<Map<String, dynamic>>> props = Map();

  PropertyList() {
    final list = List<Map<String, dynamic>>();
    list.add(PropertyBrief().toJsonMap());
    list.add(PropertyBrief().toJsonMap());

    props['prop_list'] = list;
  }

  Map<String, dynamic> toJsonMap() {
    return props;
  }
}

class PropertyBrief {
  var prop_id = "key_to_specific_property";
  var community = "济南市历下区舜华路1269号得安大厦";
  var room = "309室";
  var fund = 5072.6;

  Map<String, dynamic> toJsonMap() {
    final map = Map<String, dynamic>();
    map["prop_id"] = prop_id;
    map["community"] = community;
    map["room"] = room;
    map["fund"] = fund;
    return map;
  }
}

class OwnerInfo {
  var name = "某某";
  var id = "000000 00000000 0000";
  var tel = "13800138000";
  var email = "xxxx@xxx.com";

  Map<String, dynamic> toJsonMap() {
    final map = Map<String, dynamic>();
    map["name"] = name;
    map["id"] = id;
    map["tel"] = tel;
    map["email"] = email;

    return map;
  }
}

class PropertyInfo {
  var boughtDate = "2015年12月12日";
  var area = "112.34平";
  var price = "167002.6元";

  Map<String, dynamic> toJsonMap() {
    final map = Map<String, dynamic>();

    map["boughtDate"] = boughtDate;
    map["area"] = area;
    map["price"] = price;
    return map;
  }
}

class Account {
  var bankName = "中国交通银行";
  var accountNo = "1234567";
  var money = 15235.4;
  var interest = 323.2;
  var freezedMoney = 0;
  var freezedInterest = 0;
  var accountLog = FakeAccountLog();

  Map<String, dynamic> toJsonMap() {
    final map = Map<String, dynamic>();

    map["bankName"] = bankName;
    map["accountNo"] = accountNo;
    map["money"] = money;
    map["interest"] = interest;
    map["freezedMoney"] = freezedMoney;
    map["freezedInterest"] = freezedInterest;
    map["accountLog"] = accountLog.logs;
    return map;
  }
}

class FakeAccountLog {
  FakeAccountLog() {
    logs.add(AccountLogItem().toJsonMap());
    logs.add(AccountLogItem().toJsonMap());
    logs.add(AccountLogItem().toJsonMap());
  }
  var logs = List<Map<String, dynamic>>();
}

class AccountLogItem {
  var time = "2014-2-3";
  var desc = "结息";
  var money = "102.4";

  Map<String, dynamic> toJsonMap() {
    final map = Map<String, dynamic>();
    map["time"] = time;
    map["desc"] = desc;
    map["money"] = money;
    return map;
  }
}

class Address {
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
/*

void main() {
  var prop = Property();
  final map = Map<String, dynamic>();
  //map["addrMap"] = prop.addrMap;


  final fake = FakeAccountLog();
  //map["fake"] = fake.logs;
  map["accountMap"] = prop.accountMap;
  print(json.encode(prop.toJsonMap()));

}*/

class Community {

}

class CommInfo {
  var comm_id = "key_to_specific_community";
}

class CommunityList {
  CommunityList() {
    final list = List<Map<String, dynamic>>();
    list.add(CommunityBrief().toJsonMap());
    list.add(CommunityBrief().toJsonMap());

    comms['comm_list'] = list;
  }
  Map<String, List<Map<String, dynamic>>> comms = Map();

  Map<String, dynamic> toJsonMap() {
    return comms;
  }
}

class CommunityBrief {
  var commId = "key_to_specific_community";
  var name = "xx小区";
  var addr = "济南市历下区舜华路1269号得安大厦";

  Map<String, dynamic> toJsonMap() {
    final map = Map<String, dynamic>();
    map['comm_id'] = commId;
    map['name'] = name;
    map['addr'] = addr;
    return map;
  }
}

class CommEvent {
  var desc = "";
  var choices = [];

}

class CommEventRatio {

}