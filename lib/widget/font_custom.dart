import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utility/warna.dart';

class FontPoppins extends StatefulWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final TextAlign alignment;
  const FontPoppins({
    required this.text,
    required this.color,
    required this.size,
    required this.fontWeight,
    required this.alignment,
    super.key,
  });

  @override
  State<FontPoppins> createState() => _FontPoppinsState();
}

class _FontPoppinsState extends State<FontPoppins> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        color: widget.color,
        fontSize: widget.size,
        fontWeight: widget.fontWeight,
      ),
      textAlign: widget.alignment,
    );
  }
}

//Font Poppins 10
class FontPop10w400White extends StatefulWidget {
  final String text;
  const FontPop10w400White({
    required this.text,
    super.key,
  });

  @override
  State<FontPop10w400White> createState() => _FontPop10w400WhiteState();
}

class _FontPop10w400WhiteState extends State<FontPop10w400White> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: MyColors.white(),
      ),
    );
  }
}
//Font Poppins 12

//Font Poppins 12 white

class FontPop12w400White extends StatefulWidget {
  final String text;
  const FontPop12w400White({
    required this.text,
    super.key,
  });

  @override
  State<FontPop12w400White> createState() => _FontPop12w400WhiteState();
}

class _FontPop12w400WhiteState extends State<FontPop12w400White> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: MyColors.white(),
      ),
    );
  }
}

//Font Poppins 12 blue

class FontPop12w400Red extends StatefulWidget {
  final String text;
  const FontPop12w400Red({
    required this.text,
    super.key,
  });

  @override
  State<FontPop12w400Red> createState() => _FontPop12w400RedState();
}

class _FontPop12w400RedState extends State<FontPop12w400Red> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: MyColors.red(),
      ),
    );
  }
}

class FontPop12w400Blue extends StatefulWidget {
  final String text;
  const FontPop12w400Blue({
    required this.text,
    super.key,
  });

  @override
  State<FontPop12w400Blue> createState() => _FontPop12w400BlueState();
}

class _FontPop12w400BlueState extends State<FontPop12w400Blue> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: MyColors.blue(),
      ),
    );
  }
}

//Font Poppins 12 white

class FontPop12w400Semi extends StatefulWidget {
  final String text;
  const FontPop12w400Semi({
    required this.text,
    super.key,
  });

  @override
  State<FontPop12w400Semi> createState() => _FontPop12w400SemiState();
}

class _FontPop12w400SemiState extends State<FontPop12w400Semi> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: MyColors.semiBlack(),
      ),
    );
  }
}

//Font Poppins 14

//Font Poppins 14 red

class FontPop14w400Red extends StatefulWidget {
  final String text;
  const FontPop14w400Red({
    required this.text,
    super.key,
  });

  @override
  State<FontPop14w400Red> createState() => _FontPop14w400RedState();
}

class _FontPop14w400RedState extends State<FontPop14w400Red> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: MyColors.red(),
      ),
    );
  }
}

class FontPop14w600Red extends StatefulWidget {
  final String text;
  const FontPop14w600Red({
    required this.text,
    super.key,
  });

  @override
  State<FontPop14w400Red> createState() => _FontPop14w400RedState();
}

class _FontPop14w600RedState extends State<FontPop14w400Red> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: MyColors.red(),
      ),
    );
  }
}

//Font Poppins 14 white

class FontPop14w400White extends StatefulWidget {
  final String text;
  const FontPop14w400White({
    required this.text,
    super.key,
  });

  @override
  State<FontPop14w400White> createState() => _FontPop14w400WhiteState();
}

class _FontPop14w400WhiteState extends State<FontPop14w400White> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: MyColors.white(),
      ),
    );
  }
}

class FontPop14w600White extends StatefulWidget {
  final String text;
  const FontPop14w600White({
    required this.text,
    super.key,
  });

  @override
  State<FontPop14w600White> createState() => _FontPop14w600WhiteState();
}

class _FontPop14w600WhiteState extends State<FontPop14w600White> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: MyColors.white(),
      ),
    );
  }
}

//Font Poppins 14 black

class FontPop14w400Black extends StatefulWidget {
  final String text;
  const FontPop14w400Black({
    required this.text,
    super.key,
  });

  @override
  State<FontPop14w400Black> createState() => _FontPop14w400BlackState();
}

class _FontPop14w400BlackState extends State<FontPop14w400Black> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: MyColors.blackFont()),
    );
  }
}

class FontPop14w400BlackItalic extends StatefulWidget {
  final String text;
  const FontPop14w400BlackItalic({
    required this.text,
    super.key,
  });

  @override
  State<FontPop14w400BlackItalic> createState() =>
      _FontPop14w400BlackItalicState();
}

class _FontPop14w400BlackItalicState extends State<FontPop14w400BlackItalic> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: MyColors.blackFont(),
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

class FontPop14w600Black extends StatefulWidget {
  final String text;
  const FontPop14w600Black({
    required this.text,
    super.key,
  });

  @override
  State<FontPop14w600Black> createState() => _FontPop14w600BlackState();
}

class _FontPop14w600BlackState extends State<FontPop14w600Black> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: MyColors.blackFont()),
    );
  }
}

//Font Poppins 16

//Font Poppins 16 black

class FontPop16w400Black extends StatefulWidget {
  final String text;
  final TextAlign textAlign;
  const FontPop16w400Black({
    required this.text,
    required this.textAlign,
    super.key,
  });

  @override
  State<FontPop16w400Black> createState() => _FontPop16w400BlackState();
}

class _FontPop16w400BlackState extends State<FontPop16w400Black> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: MyColors.blackFont(),
      ),
      textAlign: widget.textAlign,
    );
  }
}

class FontPop16w600Black extends StatefulWidget {
  final String text;
  const FontPop16w600Black({
    required this.text,
    super.key,
  });

  @override
  State<FontPop16w600Black> createState() => _FontPop16w600BlackState();
}

class _FontPop16w600BlackState extends State<FontPop16w600Black> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: MyColors.blackFont()),
    );
  }
}

//Font Poppins 18

//Font Poppins 18 black

class FontPop18w400Red extends StatefulWidget {
  final String text;
  const FontPop18w400Red({
    required this.text,
    super.key,
  });

  @override
  State<FontPop18w400Red> createState() => _FontPop18w400RedState();
}

class _FontPop18w400RedState extends State<FontPop18w400Red> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: MyColors.red(),
      ),
    );
  }
}

class FontPop18w400Black extends StatefulWidget {
  final String text;
  const FontPop18w400Black({
    required this.text,
    super.key,
  });

  @override
  State<FontPop18w400Black> createState() => _FontPop18w400BlackState();
}

class _FontPop18w400BlackState extends State<FontPop18w400Black> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: MyColors.blackFont()),
    );
  }
}

class FontPop18w600Black extends StatefulWidget {
  final String text;
  const FontPop18w600Black({
    required this.text,
    super.key,
  });

  @override
  State<FontPop18w600Black> createState() => _FontPop18w600BlackState();
}

class _FontPop18w600BlackState extends State<FontPop18w600Black> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: MyColors.blackFont()),
    );
  }
}

//Font Poppins 20

//Font Poppins 20 black

class FontPop20w600Black extends StatefulWidget {
  final String text;
  const FontPop20w600Black({
    required this.text,
    super.key,
  });

  @override
  State<FontPop20w600Black> createState() => _FontPop20w600BlackState();
}

class _FontPop20w600BlackState extends State<FontPop20w600Black> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: MyColors.blackFont()),
    );
  }
}

//Font Poppins 24

//Font Poppins 24 White

class FontPop24w700White extends StatefulWidget {
  final String text;
  const FontPop24w700White({
    required this.text,
    super.key,
  });

  @override
  State<FontPop24w700White> createState() => _FontPop24w700WhiteState();
}

class _FontPop24w700WhiteState extends State<FontPop24w700White> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: MyColors.white(),
      ),
    );
  }
}

//Font Poppins 28

//Font Poppins 28 semi
class FontPop28w700Semi extends StatefulWidget {
  final String text;
  const FontPop28w700Semi({
    required this.text,
    super.key,
  });

  @override
  State<FontPop28w700Semi> createState() => _FontPop28w700SemiState();
}

class _FontPop28w700SemiState extends State<FontPop28w700Semi> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: MyColors.semiBlack(),
      ),
    );
  }
}

//Font Poppins 28 red
class FontPop28w700Red extends StatefulWidget {
  final String text;
  const FontPop28w700Red({
    required this.text,
    super.key,
  });

  @override
  State<FontPop28w700Red> createState() => _FontPop28w700RedState();
}

class _FontPop28w700RedState extends State<FontPop28w700Red> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: MyColors.red(),
      ),
    );
  }
}

//Font Poppins 28 blue

class FontPop28w700Blue extends StatefulWidget {
  final String text;
  const FontPop28w700Blue({
    required this.text,
    super.key,
  });

  @override
  State<FontPop28w700Blue> createState() => _FontPop28w700BlueState();
}

class _FontPop28w700BlueState extends State<FontPop28w700Blue> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: MyColors.blue(),
      ),
    );
  }
}
