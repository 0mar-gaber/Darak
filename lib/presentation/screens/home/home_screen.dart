import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:real_their/core/local_storage/shared_pref.dart';
import 'package:real_their/presentation/view_models/favourite_view_model/favourite_view_model.dart';

import '../../../core/reusable_components/add_apartment_sheet.dart';
import '../../../core/shared_provider/home_screen_provider.dart';
import 'tabs/discover_tab/discover_tab.dart';
import 'tabs/home_tab/home_tab.dart';
import 'tabs/profile_tab/Profile_tab.dart';
import 'tabs/wishlist_tab/wishlist_tab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> tabsList = [
    const HomeTab(),
    const DiscoverTab(),
    const WishlistTab(),
    const WishlistTab(),
    const ProfileTab()
  ];

  static const String route = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider homeScreenProvider =
        Provider.of<HomeScreenProvider>(context);


    if(PrefsHelper.getUserId()!=null){
      FavouriteViewModel.get(context).getFavourites(PrefsHelper.getUserId());
    }

    return Scaffold(

      body: Stack(
        children: [
          Positioned.fill(
            child: tabsList[homeScreenProvider.tabIndex],
          ),

          if (homeScreenProvider.visibility)
            Positioned(
              top: 100.h,
              left: 80.w,
              right: 80.w,
              child: InkWell(
                onTap: () {
                  homeScreenProvider.clearProperty();
                },
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.35), // Light shadow
                        blurRadius: 8,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],

                  ),
                  child: Center(
                    child: Text(
                      "Compare ( ${homeScreenProvider.property.length} of 2 selected )",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            if(value==2){
              return;
            }
            homeScreenProvider.changeTab(value);
          },
          currentIndex: homeScreenProvider.tabIndex,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
          items: [
            bottomNavigationBarItem(svgUrl: "assets/svg/home.svg", context: context, index: 0, label: "Home"),
            bottomNavigationBarItem(svgUrl: "assets/svg/explore.svg", context: context, index: 1, label: "Explore"),
            bottomNavigationBarItem(svgUrl: "assets/svg/chevron-up-svgrepo-com.svg", context: context, index: 2, label: "Add"),
            bottomNavigationBarItem(svgUrl: "assets/svg/ads.svg", context: context, index: 3, label: "My Ads"),
            bottomNavigationBarItem(svgUrl: "assets/svg/profile.svg", context: context, index: 4, label: "Profile"),
          ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => AddApartmentSheet(),
          ),
        shape: CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  bottomNavigationBarItem(
      {
        required String svgUrl,
        required BuildContext context,
        required int index,
        required String label
     }) {
    HomeScreenProvider homeScreenProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);

    BottomNavigationBarItem bottomNavigationBarItem = BottomNavigationBarItem(
        icon: SvgPicture.asset(
          svgUrl ,
          height: 25.h,
          colorFilter: homeScreenProvider.tabIndex == index
            ? ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn) : null,
        ),
        label: label,
    );
    return bottomNavigationBarItem;
  }
}
