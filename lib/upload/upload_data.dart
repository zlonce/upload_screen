import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class ImageUploadData {
  final File image;
  final int userId;
  final double lat;
  final double lng;
  final String location;
  final int registerTime;
  final bool frameActive;
  final bool sharedActive;

  ImageUploadData({
    required this.image,
    required this.userId,
    required this.lat,
    required this.lng,
    required this.location,
    required this.registerTime,
    required this.frameActive,
    required this.sharedActive,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'lat': lat,
        'lng': lng,
        'location': location,
        'registerTime': registerTime,
        'frameActive': frameActive,
        'sharedActive': sharedActive,
      };
}

class UserDataService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw '위치 서비스가 비활성화되어 있습니다.';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw '위치 권한이 거부되었습니다.';
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<String> getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.locality ?? ''} ${place.subLocality ?? ''}'.trim();
      }
      return '';
    } catch (e) {
      print('위치 주소 변환 실패: $e');
      return '';
    }
  }

//유저 아이디 어케 가져오지,,,,
  // static Future<int> getUserId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt('userId') ?? 'userId'; // 기본값 1
  // }
}
