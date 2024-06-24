import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class locaion extends GetxController {
  static locaion get instance => Get.find();

  Position? currentPositionfordoctor;

  getlocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('no perission ');
      }
    }

    currentPositionfordoctor = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    print('Distance to other location: $currentPositionfordoctor meters');
  }

  comperelocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('no perission ');
      }
    }

    // Example longitude

    // Get the current position

    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Calculate the distance between the current position and the other location
    double distanceInMeters = await Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      currentPositionfordoctor!.latitude,
      currentPositionfordoctor!.longitude,
    );

    print('Distance to other location: $currentPosition meters');

    return distanceInMeters;
    //print('Distance to other location: $distanceInMeters meters');
  }
}
