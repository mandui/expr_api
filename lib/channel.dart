import 'expr_api.dart';
import 'package:expr_api/controller.dart';

class ExprApiChannel extends ApplicationChannel {

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route("/example")
      .linkFunction((request) async {
        return Response.ok({"key": "value"});
      });
    
    router.route("/cors")
      .linkFunction((request) async {
        if (request.isCORSRequest)
          return Response.ok("cors",
            headers: { "Access-Control-Request-Origin" : "*"});
    });

    router
      .route("/wechat/:which/:api")
      .linkFunction((request) async {
        if (request.isCORSRequest)
          return Response.ok("cors",
              headers: { "Access-Control-Request-Origin" : "*"});
    }).link(() => ExprController());

    return router;
  }
}