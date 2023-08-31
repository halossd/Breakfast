import 'package:test/test.dart';
import 'package:fitness/models/cart.dart';
import 'package:fitness/models/catalog.dart';

//Unit test
void main() {
  group('App provider test', () {
    final cart = CartModel();
    cart.catalog = CatalogModel();

    test('A new item should be incremented', () {
      final item = Item(1, "name");
      cart.add(item);
      final bool contains = cart.items.contains(item);
      expect(contains, true);
    });

    test('An item shouled be removed', () {
      final item = Item(2, "name2");
      cart.add(item);
      bool contains = cart.items.contains(item);
      expect(contains, true);
      cart.remove(item);
      contains = cart.items.contains(item);
      expect(contains, false);
    });
  });
}
