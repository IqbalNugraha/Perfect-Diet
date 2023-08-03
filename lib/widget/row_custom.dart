import 'package:flutter/material.dart';
import 'package:skiripsi_app/provider/rekomendasi/model/model_list_saved.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/button_custom.dart';
import 'package:skiripsi_app/widget/font_custom.dart';
import 'package:skiripsi_app/widget/hitung_imt.dart';
import 'package:skiripsi_app/widget/input_custom.dart';

class RowCustom1 extends StatefulWidget {
  final String judul;
  final String output;

  const RowCustom1({
    Key? key,
    required this.judul,
    required this.output,
  }) : super(key: key);

  @override
  State<RowCustom1> createState() => _RowCustom1State();
}

class _RowCustom1State extends State<RowCustom1> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150,
          child: FontPop14w400Black(text: widget.judul),
        ),
        const Text(":"),
        const SizedBox(width: 14),
        Expanded(
          child: FontPop14w400Black(
            text: widget.output,
          ),
        ),
      ],
    );
  }
}

class RowCustom2 extends StatefulWidget {
  final String judul;
  final String output;

  const RowCustom2({
    Key? key,
    required this.judul,
    required this.output,
  }) : super(key: key);

  @override
  State<RowCustom2> createState() => _RowCustom2State();
}

class _RowCustom2State extends State<RowCustom2> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FontPop14w400Black(text: widget.judul),
        ),
        const Text(":"),
        const SizedBox(width: 14),
        SizedBox(
          width: 50,
          child: FontPop14w400Black(
            text: widget.output,
          ),
        ),
      ],
    );
  }
}

class RowCustom3 extends StatefulWidget {
  final String judul;
  final String output;

  const RowCustom3({
    Key? key,
    required this.judul,
    required this.output,
  }) : super(key: key);

  @override
  State<RowCustom3> createState() => _RowCustom3State();
}

class _RowCustom3State extends State<RowCustom3> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 80,
          child: FontPop14w400Black(text: widget.judul),
        ),
        const Text(":"),
        const SizedBox(width: 14),
        Expanded(
          child: FontPop14w400Black(
            text: widget.output,
          ),
        ),
      ],
    );
  }
}

class RowCustomNormal extends StatefulWidget {
  final String judul;
  final String satuan;
  const RowCustomNormal({
    required this.judul,
    required this.satuan,
    super.key,
  });

  @override
  State<RowCustomNormal> createState() => _RowCustomNormalState();
}

class _RowCustomNormalState extends State<RowCustomNormal> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 45,
          child: Align(
            alignment: Alignment.centerRight,
            child: FontPop14w400Black(
              text: widget.judul,
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 40,
          child: FontPop14w400Red(
            text: widget.satuan,
          ),
        ),
      ],
    );
  }
}

class RowCustomIcon extends StatefulWidget {
  final String judul;

  const RowCustomIcon({Key? key, required this.judul}) : super(key: key);

  @override
  State<RowCustomIcon> createState() => _RowCustomIconState();
}

class _RowCustomIconState extends State<RowCustomIcon> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250,
            child: FontPop16w400Black(
              textAlign: TextAlign.start,
              text: widget.judul,
            ),
          ),
          const SizedBox(width: 14),
          const Icon(
            Icons.arrow_right_rounded,
            size: 40,
          ),
        ],
      ),
    );
  }
}

class RowCustomToolbar extends StatefulWidget {
  final String toolbar;
  const RowCustomToolbar({
    required this.toolbar,
    super.key,
  });

  @override
  State<RowCustomToolbar> createState() => _RowCustomToolbarState();
}

class _RowCustomToolbarState extends State<RowCustomToolbar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(true);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 26,
            ),
          ),
          const SizedBox(width: 10),
          FontPop20w600Black(text: widget.toolbar),
        ],
      ),
    );
  }
}

class RowCustomTextField60 extends StatefulWidget {
  final TextEditingController textHeight;
  final String judul;
  final String hint;
  final String satuan;
  const RowCustomTextField60({
    required this.judul,
    required this.hint,
    required this.textHeight,
    required this.satuan,
    super.key,
  });

  @override
  State<RowCustomTextField60> createState() => _RowCustomTextField60State();
}

class _RowCustomTextField60State extends State<RowCustomTextField60> {
  InputCustom inputCustom = InputCustom();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: FontPop12w400Semi(text: widget.judul),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 80,
          height: 50,
          child: TextFormField(
            controller: widget.textHeight,
            keyboardType: TextInputType.number,
            validator: (input) => input!.isEmpty ? "Nilai Tidak Valid" : null,
            maxLength: 4,
            decoration: inputCustom.inputProfile(widget.hint),
          ),
        ),
        const SizedBox(width: 10),
        FontPop12w400Semi(text: widget.satuan),
      ],
    );
  }
}

class RowCustomTarget extends StatefulWidget {
  final Widget widget;
  final String judul;
  const RowCustomTarget({
    required this.judul,
    required this.widget,
    super.key,
  });

  @override
  State<RowCustomTarget> createState() => _RowCustomTargetState();
}

class _RowCustomTargetState extends State<RowCustomTarget> {
  InputCustom inputCustom = InputCustom();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: FontPop12w400Semi(text: widget.judul),
        ),
        const SizedBox(width: 10),
        Expanded(child: widget.widget),
      ],
    );
  }
}

class RowCustomTextFieldFull extends StatefulWidget {
  final TextEditingController textEditing;
  final String judul;
  final String hint;
  const RowCustomTextFieldFull({
    required this.judul,
    required this.hint,
    required this.textEditing,
    super.key,
  });

  @override
  State<RowCustomTextFieldFull> createState() => _RowCustomTextFieldFullState();
}

class _RowCustomTextFieldFullState extends State<RowCustomTextFieldFull> {
  InputCustom inputCustom = InputCustom();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 50,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: FontPop12w400Semi(text: widget.judul),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: widget.textEditing,
              keyboardType: TextInputType.text,
              decoration: inputCustom.inputProfile(widget.hint),
            ),
          )
        ],
      ),
    );
  }
}

class RowCustomIMT extends StatefulWidget {
  final double hasilIMT;
  final String nilaiIMT;
  const RowCustomIMT({
    required this.hasilIMT,
    required this.nilaiIMT,
    super.key,
  });

  @override
  State<RowCustomIMT> createState() => _RowCustomIMTState();
}

class _RowCustomIMTState extends State<RowCustomIMT> {
  FunctionIMT hitungIMT = FunctionIMT();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FontPop28w700Red(text: widget.hasilIMT.toString()),
        FontPop16w400Black(text: widget.nilaiIMT, textAlign: TextAlign.start),
      ],
    );
  }
}

class RowDatePicker extends StatefulWidget {
  final String judul;
  const RowDatePicker({
    required this.judul,
    super.key,
  });

  @override
  State<RowDatePicker> createState() => _RowDatePickerState();
}

class _RowDatePickerState extends State<RowDatePicker> {
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: FontPop12w400Semi(text: widget.judul),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 150,
          height: 40,
          child: GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2099),
              ).then((date) {
                setState(() {
                  dateTime = date;
                });
              });
            },
            child: FontPoppins(
              text: "$dateTime",
              color: MyColors.blackFont(),
              size: 12,
              fontWeight: FontWeight.w400,
              alignment: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}

class ColumnCustom extends StatefulWidget {
  final String nilaiIMT;
  final String hasilIMT;
  const ColumnCustom({
    required this.hasilIMT,
    required this.nilaiIMT,
    super.key,
  });

  @override
  State<ColumnCustom> createState() => _ColumnCustomState();
}

class _ColumnCustomState extends State<ColumnCustom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FontPop18w600Black(text: widget.hasilIMT),
        const SizedBox(height: 5),
        FontPop14w400Red(text: widget.nilaiIMT),
      ],
    );
  }
}

class ColumnCustomTarget extends StatefulWidget {
  final String nilaiHari;
  final String nilaiBerat;
  final String nilaiKalori;
  final String satuan1;
  final String satuan2;
  final String satuan3;
  const ColumnCustomTarget({
    required this.nilaiBerat,
    required this.nilaiHari,
    required this.nilaiKalori,
    required this.satuan1,
    required this.satuan2,
    required this.satuan3,
    super.key,
  });

  @override
  State<ColumnCustomTarget> createState() => _ColumnCustomTargetState();
}

class _ColumnCustomTargetState extends State<ColumnCustomTarget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RowCustomNormal(judul: widget.nilaiBerat, satuan: widget.satuan1),
        const SizedBox(height: 5),
        RowCustomNormal(judul: widget.nilaiHari, satuan: widget.satuan2),
        const SizedBox(height: 5),
        RowCustomNormal(judul: widget.nilaiKalori, satuan: widget.satuan3),
      ],
    );
  }
}

class RowCustomImage extends StatefulWidget {
  final String image, title, tipeDiet;
  const RowCustomImage({
    required this.tipeDiet,
    required this.image,
    required this.title,
    super.key,
  });

  @override
  State<RowCustomImage> createState() => _RowCustomImageState();
}

class _RowCustomImageState extends State<RowCustomImage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 120,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: -2,
                  blurRadius: 7,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowCustom3(judul: "Nama Makanan", output: widget.title),
                const SizedBox(height: 8),
                RowCustom3(judul: "Tipe Diet", output: widget.tipeDiet),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RowNumber extends StatefulWidget {
  final String number, value;
  const RowNumber({
    required this.number,
    required this.value,
    super.key,
  });

  @override
  State<RowNumber> createState() => _RowNumberState();
}

class _RowNumberState extends State<RowNumber> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 15,
          child: FontPop12w400Semi(
            text: widget.number,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FontPop12w400Semi(
            text: widget.value,
          ),
        ),
      ],
    );
  }
}

class ColumnCamera extends StatefulWidget {
  final String userId, idToken, title, imgUrl;
  final int sarapanValue,
      fatMax,
      carbMax,
      makanSiangValue,
      makanMalamValue,
      camilanValue,
      calValue,
      fatValue,
      carbValue,
      nutrisiCal,
      nutrisiFat,
      nutrisiCarb,
      accuracy;
  final double ngemil;
  const ColumnCamera({
    required this.title,
    required this.imgUrl,
    required this.calValue,
    required this.fatValue,
    required this.carbValue,
    required this.sarapanValue,
    required this.makanSiangValue,
    required this.makanMalamValue,
    required this.camilanValue,
    required this.fatMax,
    required this.carbMax,
    required this.ngemil,
    required this.nutrisiCal,
    required this.nutrisiFat,
    required this.nutrisiCarb,
    required this.userId,
    required this.idToken,
    required this.accuracy,
    super.key,
  });

  @override
  State<ColumnCamera> createState() => _ColumnCameraState();
}

class _ColumnCameraState extends State<ColumnCamera> {
  FunctionIMT functionIMT = FunctionIMT();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FontPoppins(
          text: "Data Makanan",
          color: MyColors.blackFont(),
          size: 16,
          fontWeight: FontWeight.w400,
          alignment: TextAlign.start,
        ),
        const SizedBox(height: 16),
        RowCustom1(
          judul: "Nama Makanan",
          output: widget.title,
        ),
        const SizedBox(height: 8),
        RowCustom1(
          judul: "Akurasi",
          output: "${widget.accuracy} %",
        ),
        const SizedBox(height: 8),
        RowCustom1(judul: "Kalori", output: "${widget.calValue} Kkal"),
        const SizedBox(height: 8),
        RowCustom1(judul: "Karbohidrat", output: "${widget.carbValue} g"),
        const SizedBox(height: 8),
        RowCustom1(judul: "Lemak", output: "${widget.fatValue} g"),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 48,
          ),
          child: SizedBox(
            width: size.width,
            height: 50,
            child: ButtonCamera(
              title: widget.title,
              imgUrl: widget.imgUrl,
              calValue: widget.calValue,
              fatValue: widget.fatValue,
              carbValue: widget.carbValue,
              sarapanValue: widget.sarapanValue,
              makanSiangValue: widget.makanSiangValue,
              makanMalamValue: widget.makanMalamValue,
              camilanValue: widget.camilanValue,
              fatMax: widget.fatMax,
              carbMax: widget.carbMax,
              ngemil: widget.ngemil,
              nutrisiCal: widget.nutrisiCal,
              nutrisiFat: widget.nutrisiFat,
              nutrisiCarb: widget.nutrisiCarb,
              userId: widget.userId,
              idToken: widget.idToken,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class TextColumn extends StatefulWidget {
  final String label;
  final TextAlign textAlign;
  const TextColumn({
    required this.label,
    required this.textAlign,
    super.key,
  });

  @override
  State<TextColumn> createState() => _TextColumnState();
}

class _TextColumnState extends State<TextColumn> {
  @override
  Widget build(BuildContext context) {
    return FontPoppins(
      text: widget.label,
      color: MyColors.blackFont(),
      size: 14,
      fontWeight: FontWeight.w600,
      alignment: widget.textAlign,
    );
  }
}
