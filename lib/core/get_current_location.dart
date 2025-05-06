import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GetCurrentLocation {
  Future<bool> _requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    } else if (permission == LocationPermission.deniedForever) {
      return false;
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      return true;
    }
    print(permission);
    return false;
  }

  Future<bool> _requestService() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Returns (Position?, errorMessage, cityName)
  Future<(Position?, String?, String?)> getCurrentLocationWithCity() async {
    bool permission = await _requestPermission();
    if (!permission) return (null, 'noPermission', null);

    bool service = await _requestService();
    if (!service) return (null, 'noService', null);

    try {
      final Position location = await Geolocator.getCurrentPosition();

      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (placemarks.isNotEmpty) {
        String city = placemarks.first.locality ?? 'Unknown';
        return (location, null, city);
      } else {
        return (location, null, 'Unknown');
      }
    } catch (e) {
      print('Reverse geocoding error: $e');
      return (null, 'geocodingError', null);
    }
  }
}
