import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class CurrentUserLocation {
  Future<String> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permantly denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          return Future.error(
              'Location permissions are denied (actual value: $permission).');
        }
      }
      final position = await Geolocator.getCurrentPosition();
      final coordinates = Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      final String realAddress =
          "${first.adminArea}- ${first.subAdminArea} - ${first.locality} - ${first.subLocality} - ${first.addressLine} - ${first.featureName}";
      return realAddress;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
