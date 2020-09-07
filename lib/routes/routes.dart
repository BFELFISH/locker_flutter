import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:locker/routes/router_handler.dart';
import 'package:locker/utils/log_utils.dart';

/***
 * 路由注册
 */
class Routes {
  static const String TAG = 'Routes';
  static Router router;
  static String root = '/';
  static String home = '/home';
  static String addGood = '/add_good';
  static String selectClassPage = '/select_class';
  static String selectLocationPage = '/select_location';
  static String selectLocationDetailPage = '/select_location_detail';
  static String addClassPage = '/add_classification';
  static String addLocationPage = '/add_location';
  static String addLocationDetailPage = '/add_location_detail';
  static String manageClassPage = '/manage_class';

  static void configureRouters(Router mRouter) {
    router = mRouter;
    router.notFoundHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
      LogUtils.d(TAG, 'Route Not Found');
      return;
    });

    router.define(root, handler: RouterHandler.rootHandler);
    router.define(home, handler: RouterHandler.homeHandler);
    router.define(addGood, handler: RouterHandler.addGoodHandler);
    router.define(selectClassPage, handler: RouterHandler.selectClassHandler);
    router.define(selectLocationPage, handler: RouterHandler.selectLocationHandler);
    router.define(addClassPage, handler: RouterHandler.addClassHandler);
    router.define(addLocationPage, handler: RouterHandler.addLocationHandler);
    router.define(addLocationDetailPage, handler: RouterHandler.addLocationDetailHandler);
    router.define(manageClassPage, handler: RouterHandler.manageClassHandler);
  }

  static Future navigateTo(BuildContext context, String path,
      {Map<String, dynamic> params,
      bool replace = false,
      bool clearStack = false,
      TransitionType transitionType,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionsBuilder}) {
    //如果参数不为空
    if (params != null) {
      String query = '';
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = '?';
        } else {
          query = query + '\&';
        }
        query += '$key=$value';
        index++;
      }
      path = path + query;
    }

    return router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: transitionType,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionsBuilder);
  }
}