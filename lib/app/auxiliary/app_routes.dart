// import 'package:app_port_cap/app/views/network_structure/json_ns.dart';
import 'package:app_port_cap/app/views/views.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const SplashUI()),
    GetPage(name: '/auth', page: () => const AuthUI()),
    // GetPage(name: '/signin', page: () => const AuthPage()),
    // GetPage(name: '/auth', page: () => AuthController()),
    GetPage(name: '/home', page: () => const HomeUi()),
    GetPage(name: '/settings', page: () => const SettingsPage()),
    // GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/profile', page: () => const ProfilePage()),
    // GetPage(name: '/ns', page: () => const LayerGraphPageFromJson()),
    GetPage(name: '/linetracker', page: () => const LineTrackerPage()),
    // GetPage(name: '/object', page: () => const ObjectUi()),
    // GetPage(name: '/report', page: () => const ChatScreen()),
    // GetPage(name: '/timeline', page: () => const TimelineUI()),
    // GetPage(name: '/about', page: () => const AboutUI()),
    GetPage(name: '/chat', page: () => const ChatScreen()),
  ];
}
