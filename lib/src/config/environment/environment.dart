class Environment {
  final String baseUrl;

  Environment({this.baseUrl=''}); 
  static bool isProduction = bool.fromEnvironment('dart.vm.product');
  static Environment debug = Environment();
  static Environment production = Environment();

  static void initializeEnvironment(){
    if(isProduction){
      production = Environment();
    }else{
      debug = Environment(
        baseUrl: 'http://192.168.5.13:3010/api/v1'
      );
    }
  }
}

final environment = Environment.isProduction ? Environment.production : Environment.debug;