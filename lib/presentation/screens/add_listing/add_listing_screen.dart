import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:real_their/core/reusable_components/property.dart'; // تأكد من المسار الصحيح
import 'package:real_their/presentation/view_models/add_listing_view_model/add_listing_view_model.dart';
import 'package:intl/intl.dart';

import '../../../core/DI/di.dart';
import '../../../core/utils/formatter.dart';
import '../../../domain/entitys/property_price_suggest_entity.dart'; // تأكد من المسار الصحيح
import '../../view_models/add_listing_view_model/suggest_price_view_model.dart'; // تأكد من المسار الصحيح

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  static const String route = "AddListingScreen";

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final List<XFile> _images = [];
  final List<String> _amenitiesOptions = [
    'Balcony',
    'Garden',
    'Swimming Pool',
    'Parking',
    'Elevator',
    'Air Conditioning',
    'Security',
    'Fitness Center',
    'Pet Friendly',
    'Fireplace',
  ];

  List<String> _selectedAmenities = [];
  String? bedRooms = '1';
  String? bathRooms = '1';
  String? flores = '1';
  String selectedStatus = "Furnished";

  // Controllers
  final TextEditingController priceController = TextEditingController(
    text: "0",
  );
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController areaController = TextEditingController(text: "0");

  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressLine1Controller = TextEditingController();
  final TextEditingController addressLine2Controller = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  final List<String> furnishingOptions = [
    "Furnished",
    "Semi-furnished",
    "Not-furnished",
  ];

  // Image picker
  Future<void> _pickImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile>? pickedImages = await picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 80,
      );

      if (pickedImages != null && pickedImages.isNotEmpty) {
        setState(() {
          // Limit to 10 images max
          final remainingSpace = 10 - _images.length;
          if (remainingSpace > 0) {
            _images.addAll(pickedImages.take(remainingSpace));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('You can only upload up to 10 images')),
            );
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick images: ${e.toString()}')),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  String _getCategoryTitle(int catIndex) {
    switch (catIndex) {
      case 1:
        return "Apartment for sale";
      case 2:
        return "Villa for sale";
      case 3:
        return "Commercial for sale";
      default:
        return "Property for sale";
    }
  }

  String _getCategorySvg(int catIndex) {
    switch (catIndex) {
      case 1:
        return "assets/svg/apartment.svg";
      case 2:
        return "assets/svg/Villa.svg";
      case 3:
        return "assets/svg/Commercial.svg";
      default:
        return "assets/svg/property.svg";
    }
  }

  String _getPropertyType(int catIndex) {
    switch (catIndex) {
      case 1:
        return "Apartment";
      case 2:
        return "Villa";
      case 3:
        return "Commercial";
      default:
        return "Property";
    }
  }

  @override
  void dispose() {
    priceController.dispose();
    nameController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    phoneNumberController.dispose();
    areaController.dispose();
    cityController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    governorateController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int catIndex = ModalRoute.of(context)!.settings.arguments as int;
    final svgIcon = _getCategorySvg(catIndex);
    final title = _getCategoryTitle(catIndex);

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<AddListingViewModel>()),
          BlocProvider(create: (_) => getIt<SuggestPriceViewModel>()),
        ],
        // تم نقل SafeArea و Form داخل MultiBlocProvider لضمان توفر BlocProviders
        child: SafeArea(
          child: Form(
            key: formKey,
            child: ListView(
              padding: REdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    SvgPicture.asset(svgIcon, width: 24.w, height: 23.h),
                    SizedBox(width: 10.w),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Image upload section
                _buildImageUploadSection(),
                SizedBox(height: 25.h),

                // Property details form
                _buildPropertyDetailsForm(catIndex),

                // Submit button
                SizedBox(height: 30.h),
                _buildSubmitButton(catIndex),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Property Images *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          height: 250.h,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5.w),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: _images.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image, size: 50.sp, color: Colors.grey),
                SizedBox(height: 10.h),
                Text(
                  "No images selected",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
              : GridView.builder(
            itemCount: _images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.file(
                      File(_images[index].path),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black54,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: 15.h),
        Center(
          child: InkWell(
            onTap: _pickImages,
            child: Container(
              width: 167.w,
              height: 50.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.2.w),
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Add Images",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                    ),
                  ),
                  Icon(Icons.image_outlined),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyDetailsForm(int catIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Area
        Text(
          "Area (m²) *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.number,
          controller: areaController,
          onTap: areaController.clear,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Area is required";
            }
            if (double.tryParse(value) == null) {
              return "Please enter a valid number";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.5.w, color: Colors.black),
            ),
            hintText: "Enter area in square meters",
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            suffixText: "m²",
            suffixStyle: TextStyle(
              fontSize: 24.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        SizedBox(height: 25.h),

        // Amenities
        Text(
          "Amenities *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        MultiSelectDialogField(
          items: _amenitiesOptions
              .map((e) => MultiSelectItem<String>(e, e))
              .toList(),
          initialValue: _selectedAmenities,
          title: Text("Select Amenities"),
          selectedColor: Theme.of(context).colorScheme.primary,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.2.w),
            borderRadius: BorderRadius.circular(5.r),
          ),
          buttonIcon: Icon(Icons.arrow_drop_down),
          buttonText: Text(
            "Select amenities",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
          onConfirm: (results) {
            setState(() {
              _selectedAmenities = results.cast<String>();
            });
          },
          backgroundColor: Colors.white,
          dialogHeight: 350.h,
          itemsTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
          checkColor: Theme.of(context).colorScheme.primary,
          chipDisplay: MultiSelectChipDisplay(
            chipColor: Theme.of(context).colorScheme.secondary,
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
        ),
        SizedBox(height: 25.h),

        // Bedrooms, Bathrooms, Floors
        _buildDropdownField(
          title: "Bedrooms *",
          value: bedRooms,
          items: ['1', '2', '3', '4', '5', '6+'],
          onChanged: (value) => setState(() => bedRooms = value),
        ),
        SizedBox(height: 25.h),

        _buildDropdownField(
          title: "Bathrooms *",
          value: bathRooms,
          items: ['1', '2', '3', '4', '5', '6+'],
          onChanged: (value) => setState(() => bathRooms = value),
        ),
        SizedBox(height: 25.h),

        _buildDropdownField(
          title: "Floor *",
          value: flores,
          items: ['1', '2', '3', '4', '5', '6+', 'Penthouse'],
          onChanged: (value) => setState(() => flores = value),
        ),
        SizedBox(height: 25.h),

        // Furnish status
        Text(
          "Furnish status *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        Column(
          children: furnishingOptions.map((option) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedStatus = option;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 6.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedStatus == option
                        ? Theme.of(context).colorScheme.primary
                        : Colors.black45,
                    width: selectedStatus == option ? 1.5 : 1.2,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      option,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    Icon(
                      selectedStatus == option
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: selectedStatus == option
                          ? Theme.of(context).colorScheme.primary
                          : Colors.black54,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 32.h),

        // Ad title
        Text(
          "Ad title *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: titleController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Title is required";
            }
            if (value.length < 10) {
              return "Title should be at least 10 characters";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.5.w, color: Colors.black),
            ),
            hintText: "Enter a descriptive title for your property",
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 30.h),

        // Description
        Text(
          "Description *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: 6,
          minLines: 4,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Description is required";
            }
            if (value.length < 30) {
              return "Description should be at least 30 characters";
            }
            return null;
          },
          controller: descriptionController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.5.w, color: Colors.black),
            ),
            hintText:
            "Describe the property in detail (features, location, etc.)",
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 30.h),

        // Location
        Text(
          "City *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: cityController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "City is required";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.5.w, color: Colors.black),
            ),
            hintText: "Enter city",
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 20.h),

        // Address Line 1
        Text(
          "Address Line 1 *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: addressLine1Controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Address is required";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.5.w, color: Colors.black),
            ),
            hintText: "Street address, P.O. box, company name",
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 20.h),

        // Address Line 2 (Optional)
        Text(
          "Address Line 2",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: addressLine2Controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.5.w, color: Colors.black),
            ),
            hintText: "Apartment, suite, unit, building, floor, etc.",
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 20.h),

        // Governorate/State
        Text(
          "Governorate/State *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: governorateController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Governorate is required";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.5.w, color: Colors.black),
            ),
            hintText: "Enter governorate or state",
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 20.h),

        // Postal Code
        Text(
          "Postal/Zip Code",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: postalCodeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.5.w, color: Colors.black),
            ),
            hintText: "Enter postal or zip code",
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 20.h),

        // Price
        Text(
          "Price *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        // هنا تم إضافة Builder للحصول على context صحيح للـ BlocProvider
        Builder(
          builder: (innerContext) { // innerContext هو السياق الجديد
            return TextFormField(
              keyboardType: TextInputType.number,
              controller: priceController,
              onChanged: (value) {
                print(cityController.text);
                final price = num.tryParse(value);
                if (price == null || areaController.text.isEmpty || bedRooms == null || bathRooms == null || flores == null || cityController.text.isEmpty) return;

                // يجب أن تكون buildingAgeYears قيمة ثابتة أو حقل إدخال
                // هنا استخدمت 5 بناءً على الكود الأصلي، لكن يفضل جعلها ديناميكية
                final entity = PropertyPriceSuggestEntity(
                  areaSqm: num.tryParse(areaController.text) ?? 0,
                  propertyType: _getPropertyType(catIndex),
                  bedrooms: int.tryParse(bedRooms!) ?? 0,
                  bathrooms: int.tryParse(bathRooms!) ?? 0,
                  buildingAgeYears: 5,
                  floorLevel: int.tryParse(flores!) ?? 0,
                  location: "Maadi", // أو LocationController.text لو موجودة
                  price: price,
                );

                // استخدام innerContext للوصول لـ ViewModel
                SuggestPriceViewModel.get(innerContext).suggestPrice(entity);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Price is required";
                }
                if (double.tryParse(value) == null) {
                  return "Please enter a valid number";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter price in EGP",
                hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: BorderSide(width: 1.5.w, color: Colors.black),
                ),
                suffixText: "\£ ",
                suffixStyle: TextStyle(
                  fontSize: 24.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          },
        ),

        // باقي الجزء الخاص بالـ BlocBuilder الخاص بـ SuggestPriceViewModel
        BlocBuilder<SuggestPriceViewModel, SuggestPriceState>(
          builder: (context, state) {
            if (state is SuggestPriceLoading) {
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  children: [
                    SizedBox(width: 10.w),
                    SizedBox(width: 18.sp, height: 18.sp, child: CircularProgressIndicator(strokeWidth: 2)),
                    SizedBox(width: 10.w),
                    Text("Analyzing...", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            }
            if (state is SuggestPriceSuccess) {
              String getAnalysisLabel(String result) {
                switch (result) {
                  case 'Normal':
                    return 'Great! Your price is in line with the current market for similar properties. ✅';
                  case 'High Anomaly':
                    return 'Your price is higher than similar properties in the market. This may make selling harder. ⚠️';
                  case 'Low Anomaly':
                    return 'Your price is lower than similar properties in the market. You might be undervaluing your property. ❗️';
                  default:
                    return result;
                }
              }

              final suggestedPrice = num.tryParse(state.response.suggestedPrice.replaceAll(',', '')) ?? 0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      getAnalysisLabel(state.response.analysisResult),
                      style: TextStyle(
                        color: state.response.analysisResult == 'Normal'
                            ? Colors.green
                            : state.response.analysisResult == 'High Anomaly'
                            ? Colors.orange
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Suggested Price: ${state.response.suggestedPrice} EGP",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      // حط السعر المقترح في الحقل
                      priceController.text = suggestedPrice.toStringAsFixed(0);

                      // ابعت الطلب تاني للتحليل، بنفس البيانات ولكن بالسعر المقترح
                      final updatedEntity = PropertyPriceSuggestEntity(
                        areaSqm: num.tryParse(areaController.text) ?? 0,
                        propertyType: _getPropertyType(catIndex),
                        bedrooms: int.tryParse(bedRooms!) ?? 0,
                        bathrooms: int.tryParse(bathRooms!) ?? 0,
                        buildingAgeYears: 5,
                        floorLevel: int.tryParse(flores!) ?? 0,
                        location: "Maadi", // أو LocationController.text لو موجودة
                        price: suggestedPrice,
                      );

                      SuggestPriceViewModel.get(context).suggestPrice(updatedEntity);
                    },
                    icon: Icon(Icons.check_circle_outline),
                    label: Text("Use Suggested Price"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              );
            }
            if (state is SuggestPriceError) {
              print(state.error);
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  "sorry we have trouble :( ",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),

        SizedBox(height: 30.h),

        // Name
        Text(
          "Your name *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Your name is required";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Enter your full name",
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.5.w, color: Colors.black),
            ),
          ),
        ),
        SizedBox(height: 30.h),

        // Phone
        Text(
          "Mobile phone *",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: TextInputType.phone,
          controller: phoneNumberController,
          maxLength: 11,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Phone number is required";
            }
            // يمكن تحسين هذا الـ regex ليناسب أرقام الهواتف المصرية تحديدًا
            if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
              return "Please enter a valid phone number";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "Enter your phone number",
            hintStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 1.5.w, color: Colors.black),
            ),
            prefixText: "+ ",
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String title,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
          ),
          value: value,
          items: items
              .map(
                (option) => DropdownMenuItem(value: option, child: Text(option)),
          )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSubmitButton(int catIndex) {
    return BlocConsumer<AddListingViewModel, AddListingState>(
      builder: (context, state) {
        if (state is AddListingLoading) {
          return ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              fixedSize: Size(double.maxFinite, 60.h),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }
        return ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (_images.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please add at least one image')),
                );
                return;
              }

              final property = Property(
                title: titleController.text,
                description: descriptionController.text,
                price: double.parse(priceController.text),
                city: cityController.text,
                addressLine1: addressLine1Controller.text,
                addressLine2: addressLine2Controller.text,
                governorate: governorateController.text,
                postalCode: postalCodeController.text,
                yourName: nameController.text,
                mobilePhone: phoneNumberController.text,
                furnishStatus: selectedStatus,
                type: _getPropertyType(catIndex),
                area: double.parse(areaController.text),
                bathrooms: int.parse(bathRooms!),
                bedrooms: int.parse(bedRooms!),
                amenities: _selectedAmenities,
                files: _images,
                floor: int.parse(flores!),
              );

              AddListingViewModel.get(context).addListing(property, _images);
            }
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(double.maxFinite, 60.h),
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            elevation: 3,
          ),
          child: Text(
            "Post Now",
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AddListingError) {
          print(state.error);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to list property: ${state.error}')),
          );
        }
        if (state is AddListingSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Property listed successfully!')),
          );
        }
        print(state);
      },
    );
  }
}