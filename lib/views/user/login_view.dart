import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:museo/constants/colors.dart';
import 'package:museo/constants/routes.dart';
import 'package:museo/extensions/buildcontext/loc.dart';
import 'package:museo/services/user_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formLoginKey = GlobalKey<FormState>();
  late String? email, password;
  final int minimumPasswordCharacters = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      appBar: AppBar(
        title: Text(
          context.loc.login_title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: mainBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              loginTitle(context),
              loginFields(context),
              enterButton(context),
              notRegistredYet(context),
              lostPasswords(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget notRegistredYet(BuildContext context) {
    return TextButton(
      child: Text(
        context.loc.not_registred_yet,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () => {
        Navigator.of(context).pushNamed(register),
      },
    );
  }

  Widget enterButton(BuildContext context) {
    return Column(
      children: [
        // Enter
        const SizedBox(height: 20),
        TextButton(
          child: Text(
            context.loc.enter,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onPressed: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            final isValid = formLoginKey.currentState!.validate();

            if (isValid) {
              formLoginKey.currentState!.save();
              await UserService().login(
                context: context,
                email: email!,
                password: password!,
              );
            }
          },
        ),
      ],
    );
  }

  Widget lostPasswords(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          context.loc.forget_password,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(userForgetPassword);
        },
      ),
    );
  }

  Widget loginFields(BuildContext context) {
    return Form(
      key: formLoginKey,
      // autovalidateMode: AutovalidateMode.always,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        children: [
          emailInput(context),
          const SizedBox(height: 15),
          passwordInput(context),
        ],
      ),
    );
  }

  Widget emailInput(BuildContext context) {
    return Column(
      children: [
        // Input Name
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            context.loc.email_hint,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: context.loc.your_email_example,
            contentPadding: const EdgeInsets.only(left: 10),
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(),
            errorStyle: const TextStyle(
              color: Colors.red,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value != null) {
              if (!EmailValidator.validate(value)) {
                return context.loc.email_not_valid;
              }
            }
            return null;
          },
          onSaved: (newValue) => setState(() {
            email = newValue;
          }),
        ),
      ],
    );
  }

  Widget loginTitle(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        context.loc.login_title_content,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
        ),
      ),
    );
  }

  Widget passwordInput(BuildContext context) {
    return Column(
      children: [
        // Input Name
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            context.loc.password_hint,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            hintText: '******',
            contentPadding: EdgeInsets.only(left: 10),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(),
            errorStyle: TextStyle(
              color: Colors.red,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                // width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value != null) {
              if (value.length < minimumPasswordCharacters) {
                return '${context.loc.password_more_characters} $minimumPasswordCharacters ${context.loc.characters}';
              }
            }
            return null;
          },
          onSaved: (newValue) => setState(() {
            password = newValue;
          }),
        ),
      ],
    );
  }
}
