import 'package:flutter/material.dart';
import 'package:skiripsi_app/utility/warna.dart';
import 'package:skiripsi_app/widget/validatitor.dart';

class TextFieldEmail extends StatefulWidget {
  final TextEditingController textEmail;
  const TextFieldEmail({
    required this.textEmail,
    super.key,
  });

  @override
  State<TextFieldEmail> createState() => _TextFieldEmailState();
}

class _TextFieldEmailState extends State<TextFieldEmail> {
  Validator validator = Validator();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        controller: widget.textEmail,
        keyboardType: TextInputType.emailAddress,
        validator: (input) {
          if (input!.isEmpty) {
            return "Email tidak boleh kosong";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: 'Email',
          filled: true,
          fillColor: MyColors.white(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: MyColors.yellow(),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: MyColors.yellow(),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldPassword extends StatefulWidget {
  final TextEditingController textPassword;
  const TextFieldPassword({
    required this.textPassword,
    super.key,
  });

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  Validator validator = Validator();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        controller: widget.textPassword,
        keyboardType: TextInputType.text,
        validator: (input) {
          if (input!.isEmpty) {
            return "Password tidak boleh kosong";
          } else if (input.length < 3) {
            return "Password tidak boleh kurang dari 3 huruf";
          } else {
            return null;
          }
        },
        obscureText: hidePassword,
        decoration: InputDecoration(
          hintText: 'Password',
          filled: true,
          fillColor: MyColors.white(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: MyColors.yellow(),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: MyColors.yellow(),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility_rounded,
              color: MyColors.yellow(),
              size: 20,
            ),
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
          ),
        ),
      ),
    );
  }
}

// class TextFieldSearch extends StatefulWidget {
//   final TextEditingController textSearch;
//   final void function;
//   final String hintText;
//   const TextFieldSearch({
//     required this.textSearch,
//     required this.function,
//     required this.hintText,
//     super.key,
//   });

//   @override
//   State<TextFieldSearch> createState() => _TextFieldSearchState();
// }

// class _TextFieldSearchState extends State<TextFieldSearch> {
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.textSearch,
//       onChanged: (String text) {
//         Future.delayed(const Duration(seconds: 3), () {
//           widget.function(te);
//         });
//       },
//       decoration: InputDecoration(
//         prefixIcon: Icon(
//           Icons.search,
//           color: MyColors.blackFont(),
//         ),
//         hintText: widget.hintText,
//         contentPadding: const EdgeInsets.all(0),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(
//             color: MyColors.red(),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(
//             color: MyColors.red(),
//           ),
//         ),
//       ),
//     );
//   }
// }
