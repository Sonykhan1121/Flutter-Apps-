import 'package:attendence_ui/attendence_features/models/employee.dart';

class PendingSyncService {
  static List<Employee> pendingUsers  = [];

  static void addUsertoQueue(Employee employee)
  {
    pendingUsers.add(employee);
  }
  static void clearQueue()
  {
    pendingUsers.clear();
  }
}