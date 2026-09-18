import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserDataController extends GetxController
{
  final _box = GetStorage();
  final username = 'Traveler'.obs;
  final ageCategory = ''.obs;
  final isSpecialNeeds = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData()
  {
    final Map<String, dynamic> userData = _box.read('currentUserProfile') ?? {};
    
    username.value = userData['username'] ?? 'Traveler';
    ageCategory.value = userData['ageCategory'] ?? 'Unknown';
    isSpecialNeeds.value = userData['isSpecialNeeds'] ?? false;
  }
  
}