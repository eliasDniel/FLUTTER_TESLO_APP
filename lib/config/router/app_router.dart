import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_teslo_app/features/shopping/presentation/shopping_car_screen.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/providers/providers.dart';
import '../../features/auth/presentation/screens/screens.dart';
import '../../features/products/products.dart';
import 'routes.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
        routes: [
          GoRoute(
            path: 'product/:productId',
            builder: (context, state) {
              final productId = state.pathParameters['productId'] ?? '';
              return ProductScreen(productId: productId);
            },
          ),
          GoRoute(
            path: 'shopping-cart',
            builder: (context, state) {
              return const ShoppingCarScreen();
            },
          )
        ],
      ),
    ],

    redirect: (context, state) {
      final isGoinTo = state.fullPath;
      final authStatus = goRouterNotifier.authStatus;
      if (isGoinTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoinTo == '/login' || isGoinTo == '/register') return null;
        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoinTo == '/login' ||
            isGoinTo == '/register' ||
            isGoinTo == '/splash') {
          return '/';
        }
      }
      return null;
    },
  );
});
