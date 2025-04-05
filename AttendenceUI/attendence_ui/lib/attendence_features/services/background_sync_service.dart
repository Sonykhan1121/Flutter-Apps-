import 'package:attendence_ui/attendence_features/services/employee_api_service.dart';
import 'package:attendence_ui/attendence_features/services/network_status.dart';
import 'package:attendence_ui/attendence_features/services/pending_sync_service.dart';

class BackgroundSyncService {
   static final apiServices = EmployeeApiService();
  static Future<void> syncPendingUsers() async {
    if(await NetworkStatus.inOnline())
      {
        for(var user in PendingSyncService.pendingUsers)
          {
            try
                {
                  await apiServices.createEmployee(user);
                  PendingSyncService.pendingUsers.remove(user);
                }
                catch(e)
    {
      print('error sending user to server');
      break;
    }
          }
      }
    else
      {
        print('No internet Connection. Retrying later');
      }
  }
}