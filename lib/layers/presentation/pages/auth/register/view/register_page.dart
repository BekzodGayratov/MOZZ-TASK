import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mozz_task/layers/presentation/extensions.dart';
import 'package:mozz_task/layers/presentation/widgets/main_button_size.dart';
import 'package:mozz_task/layers/presentation/widgets/standart_padding.dart';

//------------------------------------------------------------------------------
// PAGE
//------------------------------------------------------------------------------

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _displayNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  //
  bool _passwordIsVisible = true;

  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _displayNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Зарегистрироваться'),
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
                controller: _displayNameController,
                decoration:
                    const InputDecoration(labelText: 'Отображаемое имя'),
              ),
              Gap(20.h),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Электронная почта'),
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
                  if (v == null || v.isEmpty) {
                    return 'Required';
                  } else if (v.length < 8) {
                    return 'Пароль должен быть длиной не менее 8 символов';
                  }

                  return null;
                },
              ),
              Gap(40.h),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: const Text('У вас нет учетной записи?'))
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StandartPadding(
        child: MainButtonSize(
            child: ElevatedButton(
                onPressed: () {}, child: const Text('Зарегистрироваться'))),
      ),
    );
  }
}

//------------------------------------------------------------------------------
// VIEW
//------------------------------------------------------------------------------
