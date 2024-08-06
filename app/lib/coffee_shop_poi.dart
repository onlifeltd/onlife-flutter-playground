import 'package:flutter/material.dart';

class CoffeeShopPoi extends StatefulWidget {
  const CoffeeShopPoi({super.key, this.focused = false});

  final bool focused;

  @override
  State<CoffeeShopPoi> createState() => _CoffeeShopPoiState();
}

class _CoffeeShopPoiState extends State<CoffeeShopPoi> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      clipBehavior: Clip.hardEdge,
      height: 40,
      width: widget.focused ? 80 : 40,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: OverflowBox(
        maxWidth: 80,
        maxHeight: 40,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: const Icon(
                Icons.coffee,
                color: Colors.white,
              ),
            ),
            if (widget.focused)
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
