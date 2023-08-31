import 'package:fitness/models/cart.dart';
import 'package:fitness/models/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => _MyListItem(index),
          ))
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;
  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    var isInCart =
        context.select<CartModel, bool>((cart) => cart.items.contains(item));
    return TextButton(
      onPressed: () {
        var cart = context.read<CartModel>();
        isInCart ? cart.remove(item) : cart.add(item);
      },
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>((state) {
        if (state.contains(MaterialState.pressed)) {
          return Theme.of(context).primaryColor;
        }
        return null;
      })),
      child: isInCart
          ? const Icon(Icons.check, semanticLabel: "Added")
          : const Text('ADD'),
    );
  }
}

class _MyAppBar extends StatefulWidget {
  const _MyAppBar();

  @override
  State<_MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<_MyAppBar> {
  late bool _showBadge;
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartModel>();
    _showBadge = cart.items.isNotEmpty;
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.titleLarge),
      floating: true,
      pinned: true,
      actions: [
        badges.Badge(
          position: badges.BadgePosition.topEnd(top: 0, end: 10),
          showBadge: _showBadge,
          badgeAnimation: _showBadge
              ? const badges.BadgeAnimation.slide()
              : const badges.BadgeAnimation.fade(
                  animationDuration: Duration(milliseconds: 10)),
          badgeContent: Text('${cart.items.length}'),
          child: IconButton(
            padding: const EdgeInsets.only(right: 20),
            onPressed: () {
              context.push('/catalog/cart');
            },
            icon: SvgPicture.asset(
              'assets/icons/cart.svg',
              width: 24,
              height: 24,
            ),
          ),
        )
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index);

  @override
  Widget build(BuildContext context) {
    var item = context
        .select<CatalogModel, Item>((catalog) => catalog.getByPosition(index));
    var textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(child: Text(item.name, style: textTheme)),
            const SizedBox(width: 24),
            _AddButton(item: item)
          ],
        ),
      ),
    );
  }
}
