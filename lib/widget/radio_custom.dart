import 'package:flutter/material.dart';
import 'package:skiripsi_app/widget/font_custom.dart';

class RadioSnack extends StatefulWidget {
  final String snack;
  const RadioSnack({
    required this.snack,
    super.key,
  });

  @override
  State<RadioSnack> createState() => _RadioSnackState();
}

class _RadioSnackState extends State<RadioSnack> {
  late String _selectedSnack = widget.snack;

  void _handleSnackChange(String? value) {
    setState(() {
      _selectedSnack = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const FontPop14w400Black(text: "Tidak Ngemil"),
          leading: Radio(
            value: "tidakNgemil",
            groupValue: _selectedSnack,
            onChanged: _handleSnackChange,
          ),
        ),
        ListTile(
          title: const FontPop14w400Black(text: "Ngemil"),
          leading: Radio(
            value: "ngemil",
            groupValue: _selectedSnack,
            onChanged: _handleSnackChange,
          ),
        )
      ],
    );
  }
}
