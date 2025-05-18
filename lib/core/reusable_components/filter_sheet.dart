import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../shared_provider/home_screen_provider.dart';
import 'filter_model.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final _formatter = NumberFormat("#,##0", "en_US");

  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;
  late TextEditingController _minAreaController;
  late TextEditingController _maxAreaController;
  late TextEditingController _cityController;

  int? _rooms;
  int? _bathrooms;
  String? _propertyType;
  String? _availability;
  String? _furnished;

  @override
  void initState() {
    final filter = Provider.of<HomeScreenProvider>(context, listen: false).filter;

    _minPriceController = TextEditingController(
        text: filter.minPrice != null ? _formatter.format(filter.minPrice) : '');
    _maxPriceController = TextEditingController(
        text: filter.maxPrice != null ? _formatter.format(filter.maxPrice) : '');
    _minAreaController = TextEditingController(
        text: filter.minArea != null ? _formatter.format(filter.minArea) : '');
    _maxAreaController = TextEditingController(
        text: filter.maxArea != null ? _formatter.format(filter.maxArea) : '');
    _cityController = TextEditingController(

    );

    _rooms = filter.rooms;
    _bathrooms = filter.bathrooms;
    _propertyType = filter.propertyType;
    _availability = filter.availability;
    _furnished = filter.furnished;

    super.initState();
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _minAreaController.dispose();
    _maxAreaController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);

    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 5.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            _buildTextInput("City", _cityController),
            10.verticalSpace,
            Row(
              children: [
                Expanded(child: _buildNumberInput("Min Price", _minPriceController)),
                10.horizontalSpace,
                Expanded(child: _buildNumberInput("Max Price", _maxPriceController)),
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                Expanded(child: _buildNumberInput("Min Area", _minAreaController)),
                10.horizontalSpace,
                Expanded(child: _buildNumberInput("Max Area", _maxAreaController)),
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                Expanded(child: _buildDropdown("Rooms", [1, 2, 3, 4, 5, 6, 7, 8, 9], (val) => setState(() => _rooms = val))),
                10.horizontalSpace,
                Expanded(child: _buildDropdown("Bathrooms", [1, 2, 3, 4, 5, 6, 7, 8, 9], (val) => setState(() => _bathrooms = val))),
              ],
            ),

            10.verticalSpace,
            _buildDropdown("Property Type", ['Apartment', 'Villa'], (val) => setState(() => _propertyType = val)),
            10.verticalSpace,
            _buildDropdown("Furnished", ['Furnished', 'Not-furnished', 'Semi-furnished'], (val) => setState(() => _furnished = val)),
            20.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      provider.updateFilter(
                        FilterModel(
                          city: _cityController.text,
                          minPrice: _parseDouble(_minPriceController.text),
                          maxPrice: _parseDouble(_maxPriceController.text),
                          minArea: _parseInt(_minAreaController.text),
                          maxArea: _parseInt(_maxAreaController.text),
                          rooms: _rooms,
                          bathrooms: _bathrooms,
                          propertyType: _propertyType,
                          availability: _availability,
                          furnished: _furnished,
                        ),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(color: Theme.of(context).colorScheme.primary)
                      ),
                      backgroundColor: Theme.of(context).colorScheme.secondary
                    ),
                    child: Text(
                      "Apply",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                10.horizontalSpace,
                Container(
                  height: 55.h,
                  width: 55.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(12.r),
                    color: Theme.of(context).colorScheme.secondary
                  ),
                  child: IconButton(
                    onPressed: () {
                      provider.resetFilter();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.restart_alt),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onTap: () => controller.clear(),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.edit),
        ),
      ),
    );
  }
  Widget _buildTextInput(String label, TextEditingController controller) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        onTap: () => controller.clear(),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.edit),
        ),
      ),
    );
  }

  Widget _buildSlider(double value, double min, double max, ValueChanged<double> onChanged) {
    return Slider(
      value: value.clamp(min, max),
      min: min,
      max: max,
      divisions: 100,
      label: _formatter.format(value.round()),
      onChanged: onChanged,

    );
  }

  Widget _buildDropdown<T>(String label, List<T> items, void Function(T?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<T>(
        value: items.contains(_getDropdownValue<T>(label)) ? _getDropdownValue<T>(label) : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  T? _getDropdownValue<T>(String label) {
    switch (label) {
      case "Rooms":
        return _rooms as T?;
      case "Bathrooms":
        return _bathrooms as T?;
      case "Property Type":
        return _propertyType as T?;
      case "Availability":
        return _availability as T?;
      case "Furnished":
        return _furnished as T?;
      default:
        return null;
    }
  }

  double? _parseDouble(String input) {
    return input.isEmpty ? null : double.tryParse(input.replaceAll(',', ''));
  }

  int? _parseInt(String input) {
    return input.isEmpty ? null : int.tryParse(input.replaceAll(',', ''));
  }
}
