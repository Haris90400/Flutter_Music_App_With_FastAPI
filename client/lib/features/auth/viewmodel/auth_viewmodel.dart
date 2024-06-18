import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  final AuthRemoteRepository _authRemoteRepository = AuthRemoteRepository();
  @override
  AsyncValue<UserModel>? build() {
    return null;
  }

  Future<void> signUpUser(
      {required String name,
      required String email,
      required String password}) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );

    var val = res.fold(
      (l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      (r) => AsyncValue.data(
        r,
      ),
    );
    print(val);
  }

  Future<void> signInUser(
      {required String email, required String password}) async {
    state = const AsyncValue.loading();
    final res = await _authRemoteRepository.login(
      email: email,
      password: password,
    );

    var val = res.fold(
      (l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      (r) => AsyncValue.data(
        r,
      ),
    );
    print(val);
  }
}
