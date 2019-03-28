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
        return Response.ok("cors",
            headers: { "Access-Control-Request-Origin" : "localhost:8080"});
    });

    router
      .route("/wechat/:which/:api")
      .link(() => ExprController());

    return router;
  }
}