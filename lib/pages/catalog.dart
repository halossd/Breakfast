import 'package:fitness/models/cart.dart';
import 'package:fitness/models/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
                (context, index) => _MyListItem(index)
            ),
          )
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
    var isInCart = context.select<CartModel, bool> (
        (cart) => cart.items.contains(item)
    );
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
        })
      ),
      child: isInCart ? const Icon(Icons.check, semanticLabel: "Added") : const Text('ADD'),
    );
  }
}


class _MyAppBar extends StatelessWidget {
  const _MyAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.titleLarge),
      floating: true,
      actions: [
        IconButton(
          onPressed: () {
            context.push('/catalog/cart');
          },
          icon: SvgPicture.asset(
            'assets/icons/cart.svg',
            width: 24,
            height: 24,
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
    var item = context.select<CatalogModel, Item> (
        (catalog) => catalog.getByPosition(index)
    );
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

