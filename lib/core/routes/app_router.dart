import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppRouter {
  static final Map<String, WidgetBuilder> _routes = {
    // AppRoutes.Splash: (_) => SplashScreen(),
    AppRoutes.Home: (_) => HomeScreen(),
    // AppRoutes.Login: (_) => LoginScreen(),
    // AppRoutes.Register: (_) => RegisterScreen(),
    // AppRoutes.Profile: (_) => ProfileScreen(),
    // AppRoutes.Cart: (_) => CartScreen(),
  };

  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   if (settings.name == AppRoutes.ProductDetails) {
  //     final String productId = settings.arguments as String;
  //     return MaterialPageRoute(builder: (_) => ProductDetailsScreen(productId: productId));
  //   }
  //
  //   if (settings.name == AppRoutes.OrderDetails) {
  //     final String orderId = settings.arguments as String;
  //     return MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderId: orderId));
  //   }
  //
  //   final builder = _routes[settings.name];
  //   if (builder != null) {
  //     return MaterialPageRoute(builder: builder);
  //   }
  //
  //   return MaterialPageRoute(
  //     builder: (_) => Scaffold(
  //       body: Center(
  //         child: Text('No route defined for ${settings.name}'),
  //       ),
  //     ),
  //   );
}

// Example placeholder screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
