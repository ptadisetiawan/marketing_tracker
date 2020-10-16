import 'package:get_it/get_it.dart';
import 'package:marketing_tracker/core/utils/location_utils.dart';

GetIt locator = GetIt.instance;
void setupLocator() async {
  await locator.registerSingleton(LocationUtils());
}