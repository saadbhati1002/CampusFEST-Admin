import 'package:event/api/network/dashboard/dashboard.dart';

class DashboardRepository {
  Future<dynamic> getDashboardCountApiCall() async {
    return await DashboardNetwork.getDashboardCount();
  }
}
