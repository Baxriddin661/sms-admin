import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:etcsms/global/shared_data_provider.dart';
import 'package:etcsms/manager/locator.dart';
import 'package:etcsms/router/router.dart';
import 'package:etcsms/screen/login/login_state.dart';
import 'package:etcsms/widget/button/app_primary_button.dart';

import 'login_cubit.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state.userModel != null) {
            SharedData sharedData = locator.get<SharedData>();
            sharedData.userModel = state.userModel;
            ApplicationListingRoute().go(context);
          }
          return _buildPage(context);
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Card(
          elevation: 20,
          color: Colors.white,
          shadowColor: Colors.indigoAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome to ETC sms panel",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: cubit.login,
                  decoration: InputDecoration(
                    hintText: "Login",
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: cubit.password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.indigo,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                AppPrimaryButton(onTap: cubit.logIn, text: "Submit"),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
