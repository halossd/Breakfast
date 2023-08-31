import 'package:fitness/pages/catalog.dart';
import 'package:fitness/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fitness/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('full test', () {
    testWidgets('home page test', (tester) async {
      //アプリを開く
      await tester.pumpWidget(const MyApp());
      //タイトルは'Breakfast'である
      expect(find.text('Breakfast'), findsOneWidget);
      //SearchFieldを見つけて、'bread'を入力
      await tester.enterText(find.byType(TextField), 'bread');
      //'bread'を確認
      expect(find.text('bread'), findsOneWidget);
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('shopping', (tester) async {
      await tester.pumpWidget(const MyApp());
      //'shopping'ボタンを見つけ出し
      final Finder tab = find.text('shopping');
      expect(tab, findsOneWidget);
      //'shopping'ボタンをクリクする
      await tester.tap(tab);
      //画面を更新する
      await tester.pumpAndSettle();
      //Catalog画面に移動を確認
      expect(find.text('Catalog'), findsOneWidget);
      expect(find.byType(MyCatalog), findsOneWidget);
    });
  });
}
