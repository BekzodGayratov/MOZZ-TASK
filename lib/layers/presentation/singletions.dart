import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class MozzSvgPictureLoader {
  // Private constructor
  MozzSvgPictureLoader._init();

  // Static final instance of the class
  static final MozzSvgPictureLoader _instance = MozzSvgPictureLoader._init();

  // Factory constructor to return the same instance
  factory MozzSvgPictureLoader() {
    return _instance;
  }

  // Method to load an SVG asset
  static SvgPicture loadAsset(String assetName,
      {double? width, double? height, BoxFit? fit, Color? color}) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      color: color,
      fit: fit ?? BoxFit.contain,
    );
  }
}

class UserData {
  static late User user;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static void initUserData() {
    user = _auth.currentUser!;
  }

  static Future<void> signOut() => FirebaseAuth.instance.signOut();
}
