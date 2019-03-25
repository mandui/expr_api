import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aqueduct/aqueduct.dart';
import 'package:expr_api/fake_utils.dart';

class ExprController extends ResourceController {
  final KEY_USER_OPEN_ID = "openid";
  final KEY_USER_ID_NO = "id_no";
  final KEY_PROP_ADDR = "prop_addr";
  final KEY_PROP_ID = "prop_id";
  final KEY_COMMU_ID = "comm_id";
  final KEY_COMMU_EVENT_ID = "comm_event_id";
  final KEY_COMMU_EVENT_CHOSE = "comm_event_chose";
  final KEY_ID = "id";
  final KEY_ACCOUNT_NO = "account_no";

  /// TODO error code should not be magic number

  @Bind.path("api") String api;
  @Bind.path("which") String which;

  @Operation.post("api")
  Future<Response> testApi() async {
    print("POST: $which: $api");

    if (api == null)
      return Response.ok("lack api method");
    if (which == null)
      return Response.ok("lack which info");

    switch(which) {
      case "user": return _userOperation();

      case "property_check": return _propertyReg();
      case "property_query": return _propertyQuery();
      case "property_list": return _propertyList();
      case "property_query_no_reg": return _propertyQueryNoReg();

      case "community_list": return _communityList();
      case "community_query": return _communityQuery();
      case "community_public_events": return _communityPublicEvents();
      case "community_vote": return _communityVote();
      case "community_support_entry": return _communityEntries();

     default:
        return Response.ok("no such method supported: $api");
    }
  }

  Future<Response> _userOperation() async {
    switch (api) {
      case "user_reg": return _userReg();
      case "user_exist": return _userExist();
      case "user_del": return _userDel();
      default:
        return Response.ok("no such method supported: $api");
    }
  }

  Future<Response> _communityEntries() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_COMMU_ID)) {
      final errMap = { "err_code": 1005, "err_msg": "缺少community id"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    final retMap = Map<String, dynamic>();
    retMap["entries"] = ["小区简介", "公共事务决议", "维修事项决议"];

    return Response.ok(retMap)..contentType = ContentType.json;
  }

  Future<Response> _communityVote() async {
    final map = await request.body.decode<Map<String, dynamic>>();

    if (! map.containsKey(KEY_COMMU_EVENT_ID)) {
      final errMap = { "err_code": 1006, "err_msg": "缺少community event id值"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }
    if (! map.containsKey(KEY_COMMU_ID)) {
      final errMap = { "err_code": 1005, "err_msg": "缺少community key值"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid值"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    if (! map.containsKey(KEY_COMMU_EVENT_CHOSE)) {
      final errMap = { "err_code": 1007, "err_msg": "缺少选择值"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    final ev = CommEvent("public_ev_01", "是否修改业主大会议事规则？", ["是", "否"])
      ..ratio = [0.25, 0.15]
      ..areaRatio = [0.13, 0.29]
      ..chose = 1;
    return Response.ok(ev.toJsonMap())..contentType = ContentType.json;
  }

  Future<Response> _communityList() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    return Response.ok(CommunityList().toJsonMap())..contentType = ContentType.json;
  }

  Future<Response> _communityQuery() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_COMMU_ID)) {
      final errMap = { "err_code": 1005, "err_msg": "缺少community key值"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    return Response.ok(CommInfo().toJsonMap())..contentType = ContentType.json;
  }

  Future<Response> _communityPublicEvents() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_COMMU_ID)) {
      final errMap = { "err_code": 1005, "err_msg": "缺少community key值"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid值"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    return Response.ok(CommPublicEvents().toJsonMap())..contentType = ContentType.json;
  }


  Future<Response> _propertyList() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    return Response.ok(PropertyList().toJsonMap())..contentType = ContentType.json;
  }

  Future<Response> _propertyQuery() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_PROP_ID)) {
      final errMap = { "err_code": 1004, "err_msg": "缺少房屋的key值"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    /// add info to this open_id
    return Response.ok(Property().toJsonMap())..contentType = ContentType.json;
  }

  Future<Response> _propertyReg() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid。"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }
    if (! map.containsKey(KEY_PROP_ADDR)) {
      final errMap = { "err_code": 1003, "err_msg": "缺少房屋位置信息。"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    final errMap = { "prop_belongs": true };
    // add info to this open_id
    return Response.ok(errMap)..contentType = ContentType.json;
  }

  Future<Response> _propertyQueryNoReg() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_ID) && ! map.containsKey(KEY_ACCOUNT_NO)) {
      final errMap = { "err_code": 1009, "err_msg": "缺少身份信息或是账号信息"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    /// add info to this open_id
    return Response.ok(ListProperty().toJsonMap())..contentType = ContentType.json;
  }


  // API - user_del
  Future<Response> _userDel() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid。"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }
    // check database,

    final errMap = { "err_code": 0, "err_msg": "ok!"};
    return Response.ok(errMap)..contentType = ContentType.json;
  }

  // API - user_exist
  Future<Response> _userExist() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid。"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    final errMap = { "user_exist": false};
    return Response.ok(errMap)..contentType = ContentType.json;

  }

  // API - user_reg
  Future<Response> _userReg() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid。"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    if (! map.containsKey(KEY_USER_ID_NO)) {
      final errMap = { "err_code": 1002, "err_msg": "缺少身份证信息。"};
      return Response.ok(errMap)..contentType = ContentType.json;
    }

    final errMap = { "err_code": 0, "err_msg": "ok!"};
    return Response.ok(errMap)..contentType = ContentType.json;

  }

}