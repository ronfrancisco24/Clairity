import 'package:flutter/cupertino.dart';
import '../models/user_model.dart';
import '../services/user_datebase_service.dart';
import '../services/profile_service.dart';

class UserProvider extends ChangeNotifier {
  // User details-related
  final ProfileService _profileService = ProfileService();
  UserModel? _user;
  UserModel? get user => _user;
  bool get isLoaded => _user != null;

  Future<void> loadUserData() async {
    _user = await _profileService.getCurrentUserProfile();
    notifyListeners();
  }

  Stream<UserModel?> get userStream => _profileService.getCurrentUserProfileStream();

  Future<void> changeAvatar(int avatarIndex) async {
    await _profileService.updateUserAvatar(avatarIndex);
    _user = await _profileService.getCurrentUserProfile();
    notifyListeners();
  }

  void clearUserData() {
    _user = null;
    notifyListeners();
  }

  Stream<UserModel?> userStreamById(String uid) {
    return _profileService.getUserDetailsStreamById(uid);
  }

  // User management database
  final UserDatabaseService _userService = UserDatabaseService();

  // Live users list
  Stream<List<UserModel>> get usersStream => _userService.getUsers();

  // Live non-admin list
  Stream<List<UserModel>> get nonAdminUsersStream => _userService.getNonAdminUsers();

  // Add user
  Future<void> addUser({
    required String phoneNumber,
    required Map<String, dynamic> userData,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  }) async {
    await _userService.addUser(
      phoneNumber: phoneNumber,
      userData: userData,
      onCodeSent: onCodeSent,
      onError: onError,
    );
  }

  // Verify the creation of the user
  Future<void> verifyAndCreateUser({
    required String verificationId,
    required String smsCode,
    required Map<String, dynamic> userData,
  }) async {
    await _userService.verifyAndCreateUser(
      verificationId: verificationId,
      smsCode: smsCode,
      userData: userData,
    );
  }

  // Edit user
  Future<void> editUser(String id, Map<String, dynamic> data) async {
    await _userService.editUser(id, data);
  }

  // Delete user
  Future<void> deleteUser(String id) async {
    await _userService.deleteUser(id);
  }
}

