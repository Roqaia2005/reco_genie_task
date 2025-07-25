import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reco_genie_task/core/colors.dart';
import 'package:reco_genie_task/core/helper.dart';
import 'package:reco_genie_task/core/utils/assets_data.dart';
import 'package:reco_genie_task/core/widgets/customButton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reco_genie_task/features/auth/presentation/views/menu_view.dart';
import 'package:reco_genie_task/features/auth/presentation/views/login_view.dart';
import 'package:reco_genie_task/features/auth/presentation/widgets/customTextFormField.dart';
import 'package:reco_genie_task/features/auth/view_model/cubits/signup_cubit/signup_cubit.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is SignupSuccess) {
          setState(() {
            isLoading = false;
          });
          showSnackBar(context, "Sign up successfully");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginView()),
          );
        } else if (state is SignupFailure) {
          setState(() {
            isLoading = false;
          });
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: AppColors.primaryColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                },
              ),
            ),
            body: Form(
              key: formKey,
              child: ListView(
                children: [
                  Image(image: AssetImage(AssetsData().shop), height: 80),
                  const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.white,
                        fontFamily: "MarckScript-Regular",
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Create your account",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    icon: Icons.person,
                    controller: nameController,
                    hintText: "Name",
                    isRequired: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    icon: Icons.email,
                    controller: emailController,
                    hintText: "Email",
                    isRequired: true,
                  ),
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),

                  const SizedBox(height: 8),
                  CustomTextFormField(
                    icon: Icons.lock,
                    isPassword: true,
                    controller: passwordController,
                    hintText: "Password",
                    isRequired: true,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    isPassword: true,
                    icon: Icons.lock,
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    isRequired: true,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (!validateEmail()) return;
                        if (!validatePassword()) return;

                        if (!validateConfirmPassword()) return;

                        BlocProvider.of<SignupCubit>(
                          context,
                        ).signup(emailController.text, passwordController.text);
                      } else {
                        showSnackBar(
                          context,
                          "Please, fill all required fields",
                        );
                      }
                    },
                    text: "REGISTER",
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account ?",
                          style: TextStyle(color: Color(0xffD8DDF5)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ),
                            );
                          },
                          child: const Text(
                            " LOGIN",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool validateConfirmPassword() {
    if (passwordController.text != confirmPasswordController.text) {
      showSnackBar(context, "Passwords don't match");
      return false;
    }
    return true;
  }

  bool validatePassword() {
    if (!RegExp(r'^.{8,}$').hasMatch(passwordController.text)) {
      showSnackBar(context, "Password must contain at least 8 chars");

      return false;
    }
    return true;
  }

  bool validateEmail() {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]{2,}$');
    if (!emailRegex.hasMatch(emailController.text)) {
      showSnackBar(context, "Please enter a valid email address");
      return false;
    }
    return true;
  }
}
