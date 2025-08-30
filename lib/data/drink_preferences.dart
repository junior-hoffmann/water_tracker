import 'package:shared_preferences/shared_preferences.dart';

const String _drinkTargetKey = 'drinkTarget';

Future<void> changeTarget({required int drinkTarget}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt(_drinkTargetKey, drinkTarget);
}

Future<int> getDrinkTarget() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(_drinkTargetKey) ?? 2000;
}