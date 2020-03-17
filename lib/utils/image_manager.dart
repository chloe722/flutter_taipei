
import 'package:flutter_taipei/assets.dart';

String getImage(String icon) {

  switch (icon) {

    case "food":
      return kFoodImage;

    case "toasty":
      return kToastyImage;

    case "speaker1":
      return kSpeaker1Photo;

    case "team":
      return kGameImage;

    case "speaker2":
      return kSpeaker2Photo;

    case "microphone":
      return kLighteningTalkImage;

    case "dialogue":
      return kNetworkingImage;

    case "home":
      return kGoHomeImage;

    default:
      return "";

  }

}