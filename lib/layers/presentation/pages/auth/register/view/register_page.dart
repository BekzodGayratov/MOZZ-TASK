import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:mozz_task/layers/domain/entity/user.dart';
import 'package:mozz_task/layers/domain/usecaces/auth/register.dart';
import 'package:mozz_task/layers/domain/usecaces/user/add_user_to_db.dart';
import 'package:mozz_task/layers/presentation/extensions.dart';
import 'package:mozz_task/layers/presentation/helpers/message_displayer.dart';
import 'package:mozz_task/layers/presentation/pages/auth/register/cubit/register_page_cubit.dart';
import 'package:mozz_task/layers/presentation/pages/chat/chat_list/chat_list_page.dart';
import 'package:mozz_task/layers/presentation/widgets/loading_widget.dart';
import 'package:mozz_task/layers/presentation/widgets/main_button_size.dart';
import 'package:mozz_task/layers/presentation/widgets/standart_padding.dart';

//------------------------------------------------------------------------------
// PAGE
//------------------------------------------------------------------------------

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterPageCubit(
          register: context.read<Register>(),
          addUserToDB: context.read<AddUserToDB>()),
      child: const _RegisterPageView(),
    );
  }
}

//------------------------------------------------------------------------------
// VIEW
//------------------------------------------------------------------------------

class _RegisterPageView extends StatefulWidget {
  const _RegisterPageView();

  @override
  State<_RegisterPageView> createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<_RegisterPageView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final RegisterPageCubit _registerPageCubit;

  //
  bool _passwordIsVisible = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _registerPageCubit = BlocProvider.of<RegisterPageCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterPageCubit, RegisterPageState>(
      listener: (context, state) {
        if (state.status == RegisterPageStatus.failure) {
          showMessage(context, state.failureMessage!);
        } else if (state.status == RegisterPageStatus.success) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const ChatListPage()),
              (route) => false);
        }
      },
      builder: (context, state) {
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
                        _registerPageCubit.register(
                            user: User(
                                email: _emailController.text,
                                password: _passwordController.text));
                      }
                    },
                    child: state.status == RegisterPageStatus.loading
                        ? const Center(child: LoadingWidget())
                        : const Text('Зарегистрироваться'))),
          ),
        );
      },
    );
  }
}
