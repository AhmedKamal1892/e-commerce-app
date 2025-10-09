import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/splach_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      //
      // case AppRoutes.homeRoute:
      //   return MaterialPageRoute(builder: (_) => ProductsPage()); // أو HomeScreen() إذا فضلت الاسم ده
      //
      // case AppRoutes.loginRoute:
      // // return MaterialPageRoute(builder: (_) => const LoginScreen());

      //
      // case AppRoutes.registerRoute:
      // // return MaterialPageRoute(builder: (_) => const RegisterScreen());

      //
      // case AppRoutes.profileRoute:
      // // return MaterialPageRoute(builder: (_) => const ProfileScreen());

      //
      // case AppRoutes.cartRoute:
      // // return MaterialPageRoute(builder: (_) => const CartScreen());

      //
      // case AppRoutes.productDetailsRoute:
      //   final String productId = settings.arguments as String;
      //   // return MaterialPageRoute(builder: (_) => ProductDetailsScreen(productId: productId));

      //
      // case AppRoutes.orderDetailsRoute:
      //   final String orderId = settings.arguments as String;
      //   // return MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderId: orderId));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }
}
