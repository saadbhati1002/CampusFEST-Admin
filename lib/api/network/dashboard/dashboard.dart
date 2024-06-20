import 'package:event/api/http_manager.dart';
import 'package:event/model/dashboard/dashboard_model.dart';

class DashboardNetwork {
  static const String dashboardCountUrl = 'e_admin_dashboard_counts.php';
  static Future<dynamic> getDashboardCount() async {
    final result = await httpManager.get(
      url: dashboardCountUrl,
    );
    print(result);
    DashboardRes response = DashboardRes.fromJson(result);
    return response;
  }
}
