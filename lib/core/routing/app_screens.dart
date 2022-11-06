import '../../features/events/presentation/screens/single_event/event_single_screen.dart';
import '../../features/events/presentation/screens/home/home_screen.dart';
import 'app_routes.dart';

class AppScreens {
  static final screens = {
    AppRoutes.homeScreen: (context) => const HomeScreen(),
    // AppRoutes.addOrEditScreen: (context) => const AddOrEditEventScreen(),
    AppRoutes.singleEventScreen: (context) => const SingleEventScreen(),
  };
}
