import 'package:location/location.dart';

class LocationUtils {
  Location location = new Location();

  Future<dynamic> getLocation() async {
    PermissionStatus _permissionStaatus = await location.hasPermission();

    if (_permissionStaatus == PermissionStatus.granted) {
      bool _serviceEnabled = await location.serviceEnabled();
      if (_serviceEnabled) {
        return await location.getLocation();
      } else {
        return "Location Service not Enabled";
      }
    } else {
      if (_permissionStaatus == PermissionStatus.denied) {
        await location.requestPermission();

        return 'Permission Denied';
      } else if (_permissionStaatus == PermissionStatus.deniedForever) {
        return 'Permission Denied Forever';
      }
    }
  }
}
