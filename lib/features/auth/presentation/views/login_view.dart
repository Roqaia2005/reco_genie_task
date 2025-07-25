import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reco_genie_task/core/colors.dart';
import 'package:reco_genie_task/core/helper.dart';
import 'package:reco_genie_task/core/utils/assets_data.dart';
import 'package:reco_genie_task/core/widgets/customButton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reco_genie_task/features/auth/presentation/views/menu_view.dart';
import 'package:reco_genie_task/features/auth/presentation/views/signup_view.dart';
import 'package:reco_genie_task/features/auth/presentation/widgets/customTextFormField.dart';
import 'package:reco_genie_task/features/auth/view_model/cubits/login_cubit/login_cubit.dart';
import 'package:reco_genie_task/features/auth/view_model/cubits/login_cubit/login_state.dart';


// features/auth/presentation/views/login_view.dart

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
   
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          showSnackBar(context, "Successfully logged in");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>HomeView()  ),
          );
        } else if (state is LoginFailure) {
          isLoading = false;
          showSnackBar(context, state.error);
        } else {
          showSnackBar(context, "something went wrong");
        }
      },
      builder:
          (context, state) => ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AssetsData().donut),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(500),
                          bottomRight: Radius.circular(500),
                        ),
                      ),
                      height: 230,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 25),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Welcome back",
                          style: TextStyle(
                            fontSize: 45,
                            color: Colors.white,
                            fontFamily: 'MarckScript-Regular',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "Login to your account",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      icon: Icons.email,
                      controller: emailController,
                      hintText: "Email",
                      isRequired: true,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFormField(
                      icon: Icons.lock,
                      controller: passwordController,
                      isPassword: true,
                      hintText: "Password",
                      isRequired: true,
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          context.read<LoginCubit>().login(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                      text: "LOGIN",
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ?",
                          style: TextStyle(color: Color(0xffD8DDF5)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpView(),
                              ),
                            );
                          },
                          child: const Text(
                            " REGISTER",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
