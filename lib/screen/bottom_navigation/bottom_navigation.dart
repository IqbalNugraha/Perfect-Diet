import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:provider/provider.dart';
import 'package:skiripsi_app/provider/profile/view_model/view_profile.dart';
import 'package:skiripsi_app/screen/rekomendasi/rekomendasi_screen.dart';
import 'package:skiripsi_app/screen/home/home_screen.dart';
import 'package:skiripsi_app/screen/search_recommendation/search_screen.dart';
import 'package:skiripsi_app/screen/profile/profile_screen.dart';
import 'package:skiripsi_app/screen/camera_recommendation/camera_screen.dart';
import 'package:skiripsi_app/utility/warna.dart';

class BottomNavigation extends StatefulWidget {
  static const routeName = '/bottom_navigation';
  final String userId, idToken, initialSelectedTab;
  final int initialIndex;
  const BottomNavigation({
    required this.initialSelectedTab,
    required this.initialIndex,
    required this.idToken,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: widget.initialIndex,
      length: 5,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProfile = Provider.of<ViewProfile>(context);
    final profile = dataProfile.profile;
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        initialSelectedTab: widget.initialSelectedTab,
        labels: const ["Beranda", "Rekomendasi", "Camera", "List", "Profil"],
        icons: const [
          Icons.home_filled,
          Icons.list_alt,
          Icons.camera_alt_rounded,
          Icons.search,
          Icons.person_pin_circle_rounded,
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: MyColors.white(),
        ),
        tabIconColor: MyColors.white(),
        tabIconSelectedColor: MyColors.yellow(),
        tabBarColor: MyColors.red(),
        tabSelectedColor: MyColors.white(),
        onTabItemSelected: (int value) {
          setState(() {
            _tabController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          Center(
            child: HomeScreen(
              idToken: widget.idToken,
              userId: widget.userId,
            ),
          ),
          Center(
            child: RekomendasiScreen(
              name: profile.nama ?? "",
              idToken: widget.idToken,
              userId: widget.userId,
            ),
          ),
          Center(
            child: CameraScreen(
              username: profile.nama ?? "",
              idToken: widget.idToken,
              userId: widget.userId,
            ),
          ),
          Center(
            child: SearchScreen(
              name: profile.nama ?? "",
              idToken: widget.idToken,
              userId: widget.userId,
            ),
          ),
          Center(
            child: ProfileScreen(
              idToken: widget.idToken,
              userId: widget.userId,
            ),
          ),
        ],
      ),
    );
  }
}
