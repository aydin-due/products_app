import 'package:flutter/material.dart';
import 'package:products_app/providers/login_form_provider.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 250,
          ),
          CardContainer(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Register',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 30,
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: const _LoginForm(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())),
              child: const Text(
                '¿Ya tienes una cuenta?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
          const SizedBox(
            height: 50,
          )
        ]),
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.auth(
                  hintText: 'john.doe@gmail.com',
                  labelText: 'Email address',
                  prefixIcon: Icons.alternate_email_outlined),
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El correo es inválido';
              },
              onChanged: (value) => loginForm.email = value,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              obscureText: true,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.auth(
                  hintText: '****',
                  labelText: 'Password',
                  prefixIcon: Icons.lock_outline),
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe tener 6 caracteres';
              },
              onChanged: (value) => loginForm.password = value,
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (!loginForm.isValidForm()) return;
                        loginForm.isLoading = true;
                        final authService = Provider.of<AuthService>(context, listen: false);
                        String token? =  await authService.createUser(loginForm.email, loginForm.password);
                        loginForm.isLoading = false;
                        Navigator.pushReplacementNamed(context, 'home');
                      },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Espere...' : 'Ingresar',
                      style: const TextStyle(color: Colors.white),
                    )))
          ],
        ));
  }
}
