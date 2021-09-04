import 'dart:async';
import 'package:bloc_pattern/validator.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators implements BaseBloc {
  final _emailController =
      BehaviorSubject<String>(); //Single//use .broadcast for broadcost
  final _passwordController = BehaviorSubject<String>();

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  //Another way
  // StreamSink<String> get emailChanged => _emailController.sink;
  // StreamSink<String> get passwordChanged => _passwordController.sink;

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<bool> get submitValid =>
      CombineLatestStream.combine2(email, password, (email, password) => true);

  submit() {
    print("xyx");
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
