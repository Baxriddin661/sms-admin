import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:etcsms/model/user_model.dart';

part 'login_state.g.dart';

@CopyWith(copyWithNull: true)
class LoginState {
  final UserModel? userModel;

  LoginState({required this.userModel});
}
