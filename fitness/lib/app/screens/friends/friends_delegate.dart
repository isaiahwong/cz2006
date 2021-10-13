import 'package:fitness/repo/repo.dart';

abstract class FriendsDelegate {
  Map<String, Friend> friends = {};
  void onFriendsSelected(Friend ex);
  void onFriendsRemoved(Friend ex);
  void onFriendsChanged(Friend ex);
  bool exists(Friend ex);
  bool notExists(Friend ex);
  void onFriendsSelectionDone();
}
