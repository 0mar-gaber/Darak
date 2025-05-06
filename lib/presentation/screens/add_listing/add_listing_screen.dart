import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:real_their/core/reusable_components/property.dart';
import 'package:real_their/presentation/view_models/add_listing_view_model/add_listing_view_model.dart';

import '../../../core/DI/di.dart';
import 'add_listing_2_screen.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  static const String route = "AddListingScreen";

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final List<XFile> _images = []; // تغيير النوع من List<File> إلى List<XFile>
  final List<String> _amenitiesOptions = [
    'Balcony',
    'Garden',
    'Swimming Pool',
    'Parking',
    'Elevator'
  ];

  List<String> _selectedAmenities = [];

  String? bedRooms = '1';
  String? bathRooms = '1';
  String? flores = '1';

  String selectedStatus = "Furnished";

  TextEditingController priceController = TextEditingController(text: "0");
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController areaController = TextEditingController(text: "0");
  GlobalKey<FormState> formKay = GlobalKey();


  final List<String> options = [
    "Furnished",
    "Semi-furnished",
    "Not-furnished"
  ];


  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      setState(() {
        _images.addAll(pickedImages); // إضافة الصور كـ XFile
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    final int catIndex = ModalRoute.of(context)!.settings.arguments as int;
    String svgIcon ;
    String title ;
    if(catIndex==1){
      svgIcon = "assets/svg/apartment.svg";
      title = "Apartment for sale";
    }else if(catIndex ==2){
      svgIcon = "assets/svg/Villa.svg";
      title = "Villa for sale";
    }else{
      svgIcon = "assets/svg/Commercial.svg";
      title = "Commercial for sale";
    }
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<AddListingViewModel>(),
        child: SafeArea(
          child: Form(
            key: formKay,
            child: ListView(
              children: [
                Padding(
                  padding: REdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back_ios_new,size: 35.sp,)

                          ),
                          Spacer(),
                          CircularPercentIndicator(
                            radius: 28.0,
                            lineWidth: 9.0,
                            percent: 0.5,
                            center: Text(
                              "1/2",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            progressColor: Theme.of(context).colorScheme.primary,
                            reverse: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        children: [
                          SvgPicture.asset(svgIcon),
                          SizedBox(width: 10.w),
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 15.sp,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        width: double.infinity,
                        height: 250.h,
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.5.w),
                        ),
                        child: _images.isEmpty
                            ? Center(child: Text("No images selected"))
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
                                    File(_images[index].path), // تحويل XFile إلى File
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
                                      child: const Icon(
                                        Icons.close,
                                        size: 18,
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
                      SizedBox(height: 25.h),
                      Text(
                        "Area *",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: areaController,
                        validator: (value) {
                          if(value==null||value.isEmpty){
                            return "area is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),

                            borderSide: BorderSide(
                              width: 2.5.w,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Enter area ( m2 )",
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        "Amenities *",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
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
                          border: Border.all(
                            color: Colors.black,
                            width: 1.2.w,
                          ),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        buttonIcon: Icon(Icons.arrow_drop_down),
                        buttonText: Text(
                          "Select amenities",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onConfirm: (results) {
                          setState(() {
                            _selectedAmenities = results.cast<String>();
                          });
                        },
                        backgroundColor: Colors.white,
                        dialogHeight: 350.h,
                        itemsTextStyle: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.w500,fontSize: 16.sp),
                        checkColor: Theme.of(context).colorScheme.primary,
                        chipDisplay: MultiSelectChipDisplay(
                          chipColor: Theme.of(context).colorScheme.secondary,
                          textStyle:TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.w500,fontSize: 16.sp) ,

                        ),
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        "Bedrooms *",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          labelText: 'Select an option',
                        ),
                        value: bedRooms,
                        items: ['1', '2', '3','4','5']
                            .map((option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            bedRooms = value;
                          });
                        },
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        "Bathrooms *",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          labelText: 'Select an option',
                        ),
                        value: bathRooms,
                        items: ['1', '2', '3','4','5']
                            .map((option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            bathRooms = value;
                          });
                        },
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        "Floor *",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          labelText: 'Select an option',
                        ),
                        value: flores,
                        items: ['1', '2', '3','4','5']
                            .map((option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            flores = value;
                          });
                        },
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        "Furnish status *",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Column(
                        children: options.map((option) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedStatus = option;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 6.h),
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 1.2,
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
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 32.h,),

                      // Ad title
                      Text(
                        "Add title *",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: titleController,
                        validator: (value) {
                          if(value==null||value.isEmpty){
                            return "title is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(width: 2.5.w, color: Colors.black),
                          ),
                          hintText: "Enter title",
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
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
                          if(value==null||value.isEmpty){
                            return "description is required";
                          }
                          return null;
                        },
                        controller: descriptionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(width: 2.5.w, color: Colors.black),
                          ),
                          hintText: "Describe the property you are selling",
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      // Location
                      Text(
                        "Location *",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),

                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: locationController,
                        validator: (value) {
                          if(value==null||value.isEmpty){
                            return "location is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(width: 2.5.w, color: Colors.black),
                          ),
                          hintText: "Enter location",
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     // Navigate to location picker
                      //   },
                      //   child: Container(
                      //     padding: REdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(width: 1.5.w, color: Colors.black),
                      //       borderRadius: BorderRadius.circular(5.r),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           "Choose location",
                      //           style: TextStyle(
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.w400,
                      //             color: Colors.black54,
                      //           ),
                      //         ),
                      //         Icon(Icons.arrow_forward_ios, size: 16.sp),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      SizedBox(height: 30.h),

                      // Price
                      Text(
                        "Price *",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: priceController,
                        validator: (value) {
                          if(value==null||value.isEmpty){
                            return "price is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter price",
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(width: 2.5.w, color: Colors.black),
                          ),
                        ),
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
                          if(value==null||value.isEmpty){
                            return "your name is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your name",
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(width: 2.5.w, color: Colors.black),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      // Phone
                      Text(
                        "mobile phone *",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneNumberController,
                        validator: (value) {
                          if(value==null||value.isEmpty){
                            return "phone number is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Phone number",
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(width: 2.5.w, color: Colors.black),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      BlocConsumer<AddListingViewModel,AddListingState>(
                          builder: (context, state) {

                            if(state is AddListingLoading){
                              return ElevatedButton(
                                onPressed: () {
                                  // Submit form
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(double.maxFinite, 60.h),
                                  padding: REdgeInsets.symmetric(vertical: 14),
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                child: Center(child: CircularProgressIndicator(color: Colors.white,),),
                              );
                            }
                            return ElevatedButton(
                              onPressed: () {
                                if(formKay.currentState!.validate()){
                                  String type;
                                  if(catIndex==1){
                                    type = "Apartment";
                                  }else if(catIndex ==2){
                                    type= "Villa";
                                  }else{
                                    type = "Commercial";
                                  }



                                  Property property = Property(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    price: double.parse(priceController.text), // 1.5 million
                                    location: locationController.text,
                                    yourName: nameController.text,
                                    mobilePhone: phoneNumberController.text,
                                    furnishStatus: selectedStatus, // or you can put 'Unfurnished'
                                    type: type,
                                    area: double.parse(areaController.text), // 180 square meters
                                    bathrooms: int.parse(bathRooms!),
                                    bedrooms: int.parse(bathRooms!),
                                    amenities: _selectedAmenities, // examples
                                    files: _images, // leave empty if you don't have images yet
                                    floor: int.parse(flores!),
                                  );

                                  AddListingViewModel.get(context).addListing(property,_images);

                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(double.maxFinite, 60.h),
                                padding: REdgeInsets.symmetric(vertical: 14),
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text("Post Now", style: TextStyle(fontSize: 20.sp,color: Colors.white,fontWeight: FontWeight.w700)),
                            );
                          },
                          listener: (context, state) {
                            print(state.toString());
                            if(state is AddListingError){
                              print(state.error);
                            }
                            if(state is AddListingSuccess){

                              Navigator.pop(context);
                            }
                          },
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
