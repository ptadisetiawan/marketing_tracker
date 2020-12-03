import 'package:get_it/get_it.dart';
import 'package:marketing_tracker/core/services/firestore_service.dart';
import 'package:marketing_tracker/core/viewmodels/location_provider.dart';

GetIt locator = GetIt.instance;
void setupLocator() async {
  await locator.registerSingleton(FirestoreService());
  await locator.registerSingleton(LocationProvider());
}
