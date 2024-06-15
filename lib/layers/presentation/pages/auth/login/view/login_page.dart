import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';
import 'package:mozz_task/layers/domain/usecaces/auth/login.dart';
import 'package:mozz_task/layers/presentation/extensions.dart';
import 'package:mozz_task/layers/presentation/helpers/message_displayer.dart';
import 'package:mozz_task/layers/presentation/helpers/navigator.dart';
import 'package:mozz_task/layers/presentation/pages/auth/login/cubit/login_page_cubit.dart';
import 'package:mozz_task/layers/presentation/pages/auth/register/view/register_page.dart';
import 'package:mozz_task/layers/presentation/pages/chat/chat_list/chat_list_page.dart';
import 'package:mozz_task/layers/presentation/widgets/loading_widget.dart';
import 'package:mozz_task/layers/presentation/widgets/main_button_size.dart';
import 'package:mozz_task/layers/presentation/widgets/standart_padding.dart';

//------------------------------------------------------------------------------
// PAGE
//------------------------------------------------------------------------------

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginPageCubit(login: context.read<Login>()),
        child: const _LoginPageView());
  }
}

//------------------------------------------------------------------------------
// VIEW
//------------------------------------------------------------------------------

class _LoginPageView extends StatefulWidget {
  const _LoginPageView();

  @override
  State<_LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<_LoginPageView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  //
  late final LoginPageCubit _loginPageCubit;

  //
  bool _passwordIsVisible = true;

  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loginPageCubit = BlocProvider.of<LoginPageCubit>(context);
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
    return BlocConsumer<LoginPageCubit, LoginPageState>(
      listener: (context, state) {
        if (state.status == LoginPageStatus.failure) {
          showMessage(context, state.failureMessage!);
        } else if (state.status == LoginPageStatus.success) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const ChatListPage()),
              (route) => false);
        }
      },
      builder: (context, state) {
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
                      if (v == null || v.isEmpty) return 'Required';

                      return null;
                    },
                  ),
                  Gap(40.h),
                  TextButton(
                      onPressed: () =>
                          navigateToPage(context, const RegisterPage()),
                      child: const Text('У вас нет учетной записи?'))
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: StandartPadding(
            child: MainButtonSize(
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _loginPageCubit.login(
                            user: User(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ));
                      }
                    },
                    child: state.status == LoginPageStatus.loading
                        ? const LoadingWidget()
                        : const Text('Войти'))),
          ),
        );
      },
    );
  }
}
