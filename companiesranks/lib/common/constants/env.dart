class Env {
  Env(this.baseUrl, {debug = false}) {
    this.debug = debug;
  }
  bool debug;
  final String baseUrl;
}

mixin EnvValue {
  //static final Env development = Env('http://yourLocalIp:5000', debug: true);
  static final Env development = Env('http://127.0.0.1:5000', debug: true);
}
