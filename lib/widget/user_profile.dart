import 'package:flutter/material.dart';
import 'package:skiripsi_app/widget/font_custom.dart';

class UserProfile extends StatefulWidget {
  final String username;
  const UserProfile({
    required this.username,
    super.key,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  "assets/png/logo.png",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 15, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FontPop18w400Black(text: widget.username),
                    const FontPop14w400Black(text: "Ubah Profil"),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: SizedBox(
              height: 40,
              width: 40,
              child: Icon(
                Icons.arrow_right_rounded,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
