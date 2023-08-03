import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utility/warna.dart';
import '../../widget/user_toolbar.dart';

class ListFoodScreen extends StatefulWidget {
  final String name;
  const ListFoodScreen({required this.name,Key? key,}) : super(key: key);

  @override
  State<ListFoodScreen> createState() => _ListFoodScreenState();
}

class _ListFoodScreenState extends State<ListFoodScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: MyColors.background(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: size.width,
                  height: 120,
                  decoration: BoxDecoration(
                    color: MyColors.red(),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 54, left: 23),
                  child: UserToolbar(name: widget.name),
                ),
              ],
            ),
            Container(
              width: size.width,
              decoration: BoxDecoration(
                color: MyColors.white(),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: TabBar(
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: MyColors.red(),
                  ),
                  indicatorColor: MyColors.red(),
                  labelColor: MyColors.red(),
                  unselectedLabelColor: MyColors.lightGrey(),
                  tabs: const [
                    Tab(
                      text: 'Lemak Tinggi',
                    ),
                    Tab(
                      text: 'Karbohidrat Tinggi',
                    ),
                    Tab(
                      text: 'Kalori Tinggi',
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
