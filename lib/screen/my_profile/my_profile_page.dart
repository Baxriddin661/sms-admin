import 'package:etcsms/screen/applications/applications_bloc.dart';
import 'package:etcsms/screen/applications/applications_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/app_drawer.dart';
import '../../widget/app_text.dart';
import '../dashboard/widget/my_profile_widget.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ApplicationsBloc()..add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ApplicationsBloc>(context);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigoAccent[400],
        title: AppText(
          'My Profile',
          color: Colors.white,
        ),
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ))),
        actions: [
          MyProfileWidget(userModel: bloc.sharedData.userModel!),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Container(
          height: 300,
          width: 450,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(2, 2), blurRadius: 4),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(500)),
                      border: Border.all(color: Colors.grey)),
                  child: Icon(
                    Icons.person,
                    size: 100,
                  )),
              SizedBox(
                height: 10,
              ),
              AppText('Login: ${bloc.sharedData.userModel!.login} '),
              SizedBox(
                height: 10,
              ),
              AppText('Name: ${bloc.sharedData.userModel!.name}'),
              SizedBox(
                height: 10,
              ),
              AppText('Email: ${bloc.sharedData.userModel!.emailAddress}')
            ],
          ),
        ),
      ),
    );
  }
}
