# CompanysRanks

This is a Flutter aplication built with bloc pattern!

OBS.: In order tu run this project properly, you'll need the [Server](https://github.com/EmperorOfKree/CompanysRanks/tree/master/Server) project running as well.

## Preparing the ambient
To assemble this project, please follow the steps below:

1. Install the [Flutter interface](https://flutter.dev/docs/get-started/install);
   * Make sure to select the right OS and follow the steps carefully;
   * If you want to open the files into VSCode, you can use this [link](https://flutter.dev/docs/get-started/install);
   * For the SDK you'll have to install the Android Studio, unfortunately;
   * Remember to run the command `flutter pub get` to compile all the dependences;
   * Remember to set a emulated device or configure a real one.

2. After the installation part, you'll have to set your Enviroment IP;
   * In the [constants folder](https://github.com/EmperorOfKree/CompanysRanks/tree/master/companiesranks/lib/common/constants) you'll have to edit the env.dart file;
   * It's pre set to run in a emulated device. if you going to run it this way, you won't need to change it;
   * If you want to run it a real device, you'll have to change the IP value to your local IP.
   
## Some common comands for flutter
`flutter clean`         -> it clean all you cached stuff;  
`flutter run`           -> it run the aplication;  
`flutter pub get`       -> it compile all the dependences;  
`flutter doctor`        -> It run a diagnose of your flutter installation and display a report of the status of it;  
`flutter create <name>` -> It creates a new project with the inputed <name>.
