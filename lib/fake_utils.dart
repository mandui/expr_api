class Property {
  final addrMap = Address().toJsonMap();
  final accountMap = Account().toJsonMap();

  Map<String, dynamic> toJsonMap() {
    final map = Map<String, dynamic>();
    map["prop_addr"] = addrMap;
    map["prop_account"] = accountMap;

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