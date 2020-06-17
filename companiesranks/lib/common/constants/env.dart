class Env {
  Env(this.baseUrl, {debug = false}) {
    this.debug = debug;
  }
  bool debug;
  final String baseUrl;
}

mixin EnvValue {
  static final Env development = Env('http://192.168.15.2:5000', debug: true);
}
