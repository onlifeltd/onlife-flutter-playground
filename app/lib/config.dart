class Config {
  static String get mapboxAccessToken {
    const key = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');
    return key.isNotEmpty ? key : throw AssertionError('MAPBOX_ACCESS_TOKEN is not set');
  }
}
