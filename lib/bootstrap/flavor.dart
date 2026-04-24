enum Flavor {
  dev,
  staging,
  prod,
}

final class AppFlavor {
  AppFlavor._();

  static Flavor _current = Flavor.dev;

  static Flavor get current => _current;

  static void setFlavor(Flavor flavor) {
    _current = flavor;
  }

  static bool get isDev => _current == Flavor.dev;
  static bool get isStaging => _current == Flavor.staging;
  static bool get isProd => _current == Flavor.prod;

  static String get name => _current.name;
}