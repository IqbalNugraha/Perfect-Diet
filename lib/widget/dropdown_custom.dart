import 'package:flutter/material.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/string_custom.dart';

class DropdownAktivity extends StatefulWidget {
  final String value;
  const DropdownAktivity({
    required this.value,
    super.key,
  });

  @override
  State<DropdownAktivity> createState() => _DropdownAktivityState();
}

class _DropdownAktivityState extends State<DropdownAktivity> {
  StringCustom stringCustom = StringCustom();
  String dropdownValue = "";
  String holder = "";

  @override
  void initState() {
    dropdownValue = widget.value;
    super.initState();
  }

  void getDropdownValue() {
    setState(() {
      holder = dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      underline: Container(
        height: 2,
        color: MyColors.grey(),
      ),
      items: stringCustom.activityName
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? data) {
        setState(() {
          dropdownValue = data!;
        });
      },
    );
  }
}

class DropdownSnack extends StatefulWidget {
  final String value;
  const DropdownSnack({
    required this.value,
    super.key,
  });

  @override
  State<DropdownSnack> createState() => _DropdownSnackState();
}

class _DropdownSnackState extends State<DropdownSnack> {
  StringCustom stringCustom = StringCustom();
  late String dropdownValue = widget.value;
  String holder = "";

  void getDropdownValue() {
    setState(() {
      holder = dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      underline: Container(
        height: 2,
        color: MyColors.grey(),
      ),
      items: stringCustom.activityName
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? data) {
        setState(() {
          dropdownValue = data!;
        });
      },
    );
  }
}
