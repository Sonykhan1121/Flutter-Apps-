import 'dart:async';

import 'background_sync_service.dart';

class PeriodicSyncService{
  static void startSyncing()
  {
    Timer.periodic(Duration(minutes: 5), (timer) async{
      await BackgroundSyncService.syncPendingUsers();



    });
  }
}