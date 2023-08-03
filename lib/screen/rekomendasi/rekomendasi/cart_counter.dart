import 'package:flutter/material.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/font_custom.dart';

class CartCounter extends StatelessWidget {
  final String? counter;
  const CartCounter({
    super.key,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: MyColors.yellow(),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: FontPoppins(
          text: counter ?? "0",
          color: MyColors.white(),
          size: 10,
          fontWeight: FontWeight.w400,
          alignment: TextAlign.left,
        ),
      ),
    );
  }
}
