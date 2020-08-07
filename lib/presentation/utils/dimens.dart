class DBDimens{
  static const double PaddingQuarter = 4.0;
  static const double PaddingHalf = 8.0;
  static const double PaddingDefault = 16.0;
  static const double PaddingDouble = 32.0;

  static const double CornerDefault = 24.0;

  static ScreenSize getScreenSize(double value){
    if(value > 600){
      return ScreenSize.LARGE;
    } else if(value > 400 && value < 600) {
      return ScreenSize.MEDIUM;
    } else {
      return ScreenSize.SMALL;
    }
  }
}

enum ScreenSize {
  LARGE,
  MEDIUM,
  SMALL
}