import 'package:fitness/repo/repo.dart';

abstract class FriendsDelegate {
  int friendsLimit = 100;
  Map<String, Friend> pendingFriends = {};
  void onFriendsSelected(Friend ex);
  // bad design
  void onFriendsSelectedWithParam(Friend ex, bool notify) {}
  void onFriendsRemoved(Friend ex);
  void onFriendsChanged(Friend ex);
  bool friendExists(Friend ex);
  bool friendNotExists(Friend ex);
  void onFriendsSelectionDone();
}
