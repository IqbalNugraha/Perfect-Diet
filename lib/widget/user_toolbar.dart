import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skiripsi_app/widget/font_custom.dart';

class UserToolbar extends StatefulWidget {
  final String name;
  const UserToolbar({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  State<UserToolbar> createState() => _UserToolbarState();
}

DateTime tanggal = DateTime.now();

class _UserToolbarState extends State<UserToolbar> {
  String formatTanggal = DateFormat.yMMMMd().format(tanggal);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FontPop12w400White(text: formatTanggal),
              const SizedBox(
                height: 4,
              ),
              FontPop24w700White(text: widget.name),
            ],
          ),
        ],
      ),
    );
  }
}
