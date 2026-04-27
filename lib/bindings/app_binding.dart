import 'package:get/get.dart';
import '../controllers/controllers.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavController>(() => NavController(), fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<WorkoutController>(() => WorkoutController(), fenix: true);
    Get.lazyPut<ProgressController>(() => ProgressController(), fenix: true);
    Get.lazyPut<DietController>(() => DietController(), fenix: true);
    Get.lazyPut<MembershipController>(() => MembershipController(), fenix: true);
  }
}
