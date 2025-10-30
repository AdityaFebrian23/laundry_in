import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
  }

  static Future<Position?> currentPosition() async {
    final ok = await checkPermission();
    if (!ok) return null;
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
}
