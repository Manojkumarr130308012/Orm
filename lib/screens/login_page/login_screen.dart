import 'package:dms_dealers/screens/login_page/login_event.dart';
import 'package:dms_dealers/screens/login_page/model/LoginResponseModel.dart';
import 'package:dms_dealers/utils/color_resources.dart';
import 'package:dms_dealers/utils/contants.dart';
import 'package:dms_dealers/utils/image_resources.dart';
import 'package:dms_dealers/utils/singleton.dart';
import 'package:dms_dealers/utils/widgets_utlis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../base/base_state.dart';
import '../../router.dart';
import '../../utils/perference_helper.dart';
import '../../utils/preference_manager.dart';
import '../../utils/text_form_field_widget.dart';
import '../../utils/validate_operations.dart';
import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc bloc;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mbleNoCntrl = TextEditingController();
  BuildContext? showpopcontext;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController =
      TextEditingController(text: "SiteAdmin@Orienseam");
  TextEditingController passwordController =
      TextEditingController(text: "123@EAMADmin");
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String fcmToken = "Getting Firebase Token";

  bool? get validate => _formKey.currentState?.validate();
  @override
  void dispose() {
    _mbleNoCntrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getTokenz();
    _getStoragePermission();
    bloc = BlocProvider.of<LoginBloc>(context);
  }

  showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        showpopcontext = context;
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: bloc,
      listener: (BuildContext context, BaseState state) async {},
      child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, BaseState state) {
            if (state is InitialState) {
              return const Center(
                child: Text('Loading state'),
              );
            } else if (state is SuccessState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (state.successResponse is Login) {
                  final Login response = state.successResponse;
                  if (response.statusCode == Constants.successCode) {
                    print(
                        "print(event.arguments);${response.result.firstName}");
                    PreferenceHelper.setBearer(response.result.accessToken);
                    PreferenceHelper.setUserName(
                        "${response.result.firstName}${response.result.lastName}");
                    PreferenceHelper.setId(response.result.id);
                    PreferenceHelper.setLoginStatus(true);
                    hideLoader();
                    showToast('Login Successfully');
                    Navigator.pushNamed(context, AppRoutes.drawerScreen);
                  }
                }
              });
            }
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade200),
                                  height: 50,
                                  width: 50,
                                  child: IconButton(
                                    icon: const Icon(Icons.settings),
                                    onPressed: () {
                                      Navigator.pushNamed(context, AppRoutes.url);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _inputField(context, state, ontap: () async {
                              if (validate != null && validate == true) {
                                print("email" + emailController.text.trim());
                                print(
                                    "password" + passwordController.text.trim());
                                print("fcm" + fcmToken);
                                print(
                                    "url${SharedPreferenceUtils.getString('eamAPIBaseURL')!}");
                
                                showLoader();
                                final Map<String, dynamic> data = {
                                  "email": emailController.text.trim(),
                                  "password": passwordController.text.trim(),
                                  "deviceToken": fcmToken
                                };
                                bloc.add(LoginRequested(
                                    context: context, arguments: data));
                              }
                            })
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  hideLoader() {
    if (showpopcontext != null) {
      Navigator.of(showpopcontext!).pop();
    }
  }

  getTokenz() async {
    String? token = await _firebaseMessaging.getToken();
    fcmToken = token!;
    print("fcmToken $fcmToken");
  }

  Future _getStoragePermission() async {
    final permissionStatus = await Permission.storage.status;
    if (permissionStatus.isDenied) {
      // Here just ask for the permission for the first time
      await Permission.storage.request();
    } else if (permissionStatus.isPermanentlyDenied) {
      // Here open app settings for user to manually enable permission in case
      // where permission was permanently denied
      await openAppSettings();
    } else {
      // Do stuff that require permission here
    }
  }

  _header(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tittle',
              style: const TextStyle(fontSize: 34, color: Colors.red),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context, state, {Function()? ontap}) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _EmailFormField(emailController: emailController),
          _PasswordFormField(passwordController: passwordController),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: ontap,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child:
                const Text(
              "Login",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  _forgotPassword(context) {
    return TextButton(
        onPressed: () {
          GoRouter.of(context).push("/forgot-password");
        },
        child: const Text("Forgot password?"));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(onPressed: () {}, child: const Text("Sign Up"))
      ],
    );
  }
}

class _EmailFormField extends StatelessWidget {
  const _EmailFormField({
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: emailController,
      title: Constants.emailTitle,
      hintText: Constants.emailHint,
      prefixIcon: Icons.person_2_outlined,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      validator: (value) => ValidateOperations.emailValidation(value),
    );
  }
}

class _PasswordFormField extends StatelessWidget {
  const _PasswordFormField({
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: passwordController,
      title: Constants.passwordTitle,
      hintText: Constants.passwordHint,
      prefixIcon: Icons.lock_outline_rounded,
      isPassword: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}
