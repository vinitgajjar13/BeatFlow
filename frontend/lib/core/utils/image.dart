

class TImage {
  static const onboarding1 = "assets/images/On boarding-1.png";
  static const onboarding2 = "assets/images/On boarding-2.png";
  static const onboarding3 = "assets/images/On boarding-3.png";
  static const logo = "assets/logo/logo.png";

  /// Returns the image asset string.
  static String getOnboardingImage(int index) {
    switch (index) {
      case 0: return onboarding1;
      case 1: return onboarding2;
      case 2: return onboarding3;
      default: return onboarding1;
    }
  }
}
