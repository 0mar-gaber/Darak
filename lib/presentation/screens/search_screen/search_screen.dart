import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:real_their/core/DI/di.dart';
import 'package:real_their/core/reusable_components/filter_bottom_sheet_widget.dart';
import 'package:real_their/core/reusable_components/search_result_widget.dart';
import 'package:real_their/core/reusable_components/text_field.dart';

import '../../../core/reusable_components/filter_sheet.dart';
import '../../../core/shared_provider/home_screen_provider.dart';
import '../../view_models/search_screen_view_model/search_screen_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String route = 'SearchScreen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider provider = Provider.of<HomeScreenProvider>(context);
    bool hasFiltersOrSearch(HomeScreenProvider provider, String query) {
      final f = provider.filter;
      return query.isNotEmpty ||
          f.city != null ||
          f.minPrice != null ||
          f.maxPrice != null ||
          f.minArea != null ||
          f.maxArea != null ||
          f.rooms != null ||
          f.bathrooms != null ||
          f.propertyType != null ||
          f.furnished != null ||
          f.availability != null;
    }


    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 20.w),
                Text(
                  'Search',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Expanded(
                  child: EditText(
                    onChanged: (text) {
                      setState(() {
                        searchQuery = text;
                      });
                    },
                    lapel: 'Search for...',
                    obscureText: false,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    formKay: GlobalKey(),
                    controller: controller,
                    iconButton: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/svg/search_icon.svg'),
                    ),
                    decorate: false,
                  ),
                ),
                const SizedBox(width: 20),
                !hasFiltersOrSearch(provider, searchQuery)
                    ? InkWell(
                  onTap: () {
                    provider.resetFilter();
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => FilterBottomSheet(),
                    );
                  },
                  child: Container(
                    width: 60.w,
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      border: Border.all(color: const Color(0xffDEEAFD)),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset('assets/svg/filter_icon.svg'),
                    ),
                  ),
                )
                    : InkWell(
                  onTap: () {
                    setState(() {
                      searchQuery='';
                      controller.value=TextEditingValue.empty;
                      provider.filter.reset();

                    });
                  },
                  child: Container(
                    width: 60.w,
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(color: const Color(0xffDEEAFD)),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: Icon(Icons.restart_alt, color: Colors.white, size: 30.sp),
                    ),
                  ),
                )
                ,
              ],
            ),
            SizedBox(height: 20.h),
            BlocProvider.value(
              value:
                  getIt<GetSearchPropertiesViewModel>()
                    ..getSearchProperties(provider.filter, searchQuery),
              child: BlocBuilder<
                GetSearchPropertiesViewModel,
                GetSearchPropertiesState
              >(
                builder: (context, state) {
                  if (state is LoadingGetSearchPropertiesState) {
                    return SizedBox();
                  }
                  if (state is SuccessGetSearchPropertiesState) {
                    var properties = state.properties;
                    print(properties.length);
                    return Expanded(
                      child: ListView.separated(
                        itemCount: hasFiltersOrSearch(provider, searchQuery) ? properties.length : 0,
                        separatorBuilder: (context, index) => SizedBox(height: 20.h,),
                        itemBuilder: (context, index) {
                          var property = properties[index];
                          return SearchResultWidget(
                            id: property.id,
                            title: property.title,
                            location: property.locationShort,
                            priceFormatted: property.priceFormatted,
                            imageUrl: property.mainImageUrl,
                            area: property.area.toString(),
                          );
                        },
                      ),
                    );
                  } else if (state is ErrorGetSearchPropertiesState) {
                    return Text(
                      state.error,
                      style: TextStyle(color: Colors.red, fontSize: 16.sp),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
