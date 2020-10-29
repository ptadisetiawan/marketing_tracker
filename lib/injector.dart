import 'package:get_it/get_it.dart';
import 'package:marketing_tracker/core/services/firestore_service.dart';

GetIt locator = GetIt.instance;
void setupLocator() async {
  await locator.registerSingleton(FirestoreService());
}
