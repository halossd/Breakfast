import 'package:fitness/models/cart.dart';
import 'package:fitness/models/catalog.dart';
import 'package:fitness/pages/cart.dart';
import 'package:fitness/pages/catalog.dart';
import 'package:fitness/pages/tabs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

GoRouter router() {
  return GoRouter(
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