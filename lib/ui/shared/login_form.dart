import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:project_lyca/blocs/blocs.dart';
import 'package:project_lyca/ui/screens/register_screen.dart';
import 'package:project_lyca/ui/screens/screens.dart';
import 'package:project_lyca/ui/shared/shared.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _EmailInput(),
              _PasswordInput(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _forgotPasswordButton(context),
                  _LoginButton(),
                ],
              ),
              DividerWithText(text: 'OR'),
              _googleLoginButton(context),
              _appleLoginButton(context),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: _signUpButton(context),
        ),
      ],
    );
  }
}

Widget _signUpButton(BuildContext context) {
  return TextButton(
    child: Text('Sign up'),
    onPressed: () {
      Navigator.of(context).push(RegisterScreen.route());
    },
  );
}

Widget _forgotPasswordButton(BuildContext context) {
  return TextButton(
    child: Text('Forgot password?'),
    onPressed: () {
      Navigator.of(context).push(ForgotPasswordScreen.route());
    },
  );
}

Widget _googleLoginButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      var authBloc = BlocProvider.of<LoginBloc>(context, listen: false);
      authBloc.add(LoginWithGoogle());
    },
    child: Text('Login with Google'),
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
  );
}

Widget _appleLoginButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {},
    child: Text('Login with Apple'),
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
    ),
  );
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginEmailChanged(username)),
          decoration: InputDecoration(
            labelText: 'email',
            errorText: state.email.invalid ? 'invalid username' : null,
          ),
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('loginForm_continue_raisedButton'),
          child: const Text('Login'),
          onPressed: state.status == FormzStatus.valid ||
                  state.status == FormzStatus.submissionInProgress
              ? () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  context.read<LoginBloc>().add(const LoginSubmitted());
                }
              : null,
        );
      },
    );
  }
}
