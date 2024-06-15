import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mozz_task/layers/presentation/extensions.dart';
import 'package:mozz_task/layers/presentation/helpers/navigator.dart';
import 'package:mozz_task/layers/presentation/pages/auth/register/view/register_page.dart';
import 'package:mozz_task/layers/presentation/widgets/main_button_size.dart';
import 'package:mozz_task/layers/presentation/widgets/standart_padding.dart';

//------------------------------------------------------------------------------
// PAGE
//------------------------------------------------------------------------------

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  //
  bool _passwordIsVisible = true;

  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Войти'),
      ),
      body: StandartPadding(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Электронная почта'),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Required';
                  } else if (!v.isValidEmail()) {
                    return 'Неверный адрес электронной почты';
                  }
          
                  return null;
                },
              ),
              Gap(20.h),
              TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: _passwordIsVisible,
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: 'Пароль',
                    suffixIcon: IconButton(
                        onPressed: () => setState(() {
                              _passwordIsVisible = !_passwordIsVisible;
                            }),
                        icon: Icon(_passwordIsVisible
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye))),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
          
                  return null;
                },
              ),
              Gap(40.h),
              TextButton(
                  onPressed: () => navigateToPage(context, const RegisterPage()),
                  child: const Text('У вас нет учетной записи?'))
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StandartPadding(
        child: MainButtonSize(
            child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: const Text('Войти'))),
      ),
    );
  }
}

//------------------------------------------------------------------------------
// VIEW
//------------------------------------------------------------------------------
