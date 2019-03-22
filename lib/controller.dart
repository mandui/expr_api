import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aqueduct/aqueduct.dart';
import 'package:expr_api/fake_utils.dart';

class ExprController extends ResourceController {
  final KEY_USER_OPEN_ID = "openid";
  final KEY_USER_ID_NO = "id_no";
  final KEY_USER_PROP_ADDR = "prop_addr";
  final KEY_USER_PROP_ID = "prop_id";
  /// TODO error code should not be magic number


  @Bind.query("api") String api;

  @Operation.post()
  Future<Response> testApi() async {
    print("POST: $api");

    if (api == null)
      return Response.ok("lack api method");

    switch(api) {
      case "user_reg": return _userReg();
      case "user_exist": return _userExist();
      case "user_del": return _userDel();

      case "property_check": return _propertyReg();
      case "property_id": return _propertyQuery();

      default:
        return Response.ok("no such method supported: $api");
    }
  }



  Future<Response> _propertyQuery() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_USER_PROP_ID)) {
      final errMap = { "err_code": 1004, "err_msg": "缺少房屋的key值"};
      return Response.ok(json.encode(errMap))..contentType = ContentType.json;
    }

    final propMap = Property().toJsonMap();
    /// add info to this open_id
    return Response.ok(json.encode(propMap))..contentType = ContentType.json;
  }

  Future<Response> _propertyReg() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid。"};
      return Response.ok(json.encode(errMap))..contentType = ContentType.json;
    }
    if (! map.containsKey(KEY_USER_PROP_ADDR)) {
      final errMap = { "err_code": 1003, "err_msg": "缺少房屋位置信息。"};
      return Response.ok(json.encode(errMap))..contentType = ContentType.json;
    }

    final errMap = { "prop_belongs": true };
    // add info to this open_id
    return Response.ok(json.encode(errMap))..contentType = ContentType.json;
  }


  // API - user_del
  Future<Response> _userDel() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid。"};
      return Response.ok(json.encode(errMap))..contentType = ContentType.json;
    }
    // check database,

    final errMap = { "err_code": 0, "err_msg": "ok!"};
    return Response.ok(json.encode(errMap))..contentType = ContentType.json;
  }

  // API - user_exist
  Future<Response> _userExist() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid。"};
      return Response.ok(json.encode(errMap))..contentType = ContentType.json;
    }

    final errMap = { "user_exist": false};
    return Response.ok(json.encode(errMap))..contentType = ContentType.json;

  }

  // API - user_reg
  Future<Response> _userReg() async {
    final map = await request.body.decode<Map<String, dynamic>>();
    if (! map.containsKey(KEY_USER_OPEN_ID)) {
      final errMap = { "err_code": 1001, "err_msg": "缺少openid。"};
      return Response.ok(json.encode(errMap))..contentType = ContentType.json;
    }

    if (! map.containsKey(KEY_USER_ID_NO)) {
      final errMap = { "err_code": 1002, "err_msg": "缺少身份证信息。"};
      return Response.ok(json.encode(errMap))..contentType = ContentType.json;
    }

    final errMap = { "err_code": 0, "err_msg": "ok!"};
    return Response.ok(json.encode(errMap))..contentType = ContentType.json;

  }

}