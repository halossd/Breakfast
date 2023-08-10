import 'package:fitness/models/cart.dart';
import 'package:fitness/models/catalog.dart';
import 'package:fitness/pages/cart.dart';
import 'package:fitness/pages/catalog.dart';
import 'package:fitness/pages/login.dart';
import 'package:fitness/pages/tabs.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/router.dart';
import 'package:provider/provider.dart';
import 'pages/home.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
GlobalKey<NavigatorState>(debugLabel: 'shell');

GoRouter router() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Tabs()
      ),
      GoRoute(
          path: '/catalog',
          builder: (context, state) => const MyCatalog(),
          routes: [
            GoRoute(
              path: 'cart',
              builder: (context, state) => const MyCart(),
            )
          ]
      ),
    ]
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(fontFamily: 'Poppins'),
    //   home: HomePage(),
    // );
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel> (
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        )
      ],
      // child: MaterialApp(
      //   theme: ThemeData(fontFamily: 'Poppins'),
      //   debugShowCheckedModeBanner: false,
      //   initialRoute: '/',
      //   onGenerateRoute: onGenerateRoute,
      // ),
      child: MaterialApp.router(
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        routerConfig: router(),
      ),
    );
  }
}