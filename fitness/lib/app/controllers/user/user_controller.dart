import 'package:fitness/app/controllers/auth/auth_controller.dart';
import 'package:fitness/repo/repo.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';
import 'package:hiit_api/hiit.dart';

typedef UserCallback = void Function(User);

class UserController extends GetxController {
  final AuthController authController = AuthController.get();

  final UserRepo _userRepo;
  final UserCallback? initWhenAuth;

  HIITServiceClient hiitClient;
  ResponseStream<InviteWaitingRoomRequest>? invitationRequest;

  Rxn<User> user = Rxn<User>();

  bool _init = false;

  UserController({
    required UserRepo userRepo,
    required this.hiitClient,
    this.initWhenAuth,
  }) : _userRepo = userRepo {
    user.listen(onUserChange);
  }

  factory UserController.get() {
    return Get.find();
  }

  void onUserChange(User? user) {
    if (user == null) return;
    if (!_init && initWhenAuth != null) initWhenAuth!(user);
  }

  void connect() {
    invitationRequest = hiitClient.subInvites(
      WorkoutUser(
        id: user.value!.id,
        name: user.value!.name,
        email: user.value!.email,
      ),
    );
    invitationRequest!.listen((value) {});
  }

  @override
  void onReady() async {
    ever(authController.currentAuth, handleAuthChanged);

    super.onReady();
  }

  handleAuthChanged(Auth? auth) async {
    if (auth == null) return;
    user.bindStream(_userRepo.streamUser());
  }
}
