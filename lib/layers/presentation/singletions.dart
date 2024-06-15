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
  static SvgPicture loadAsset(String assetName, {double? width, double? height}) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
    );
  }
}
