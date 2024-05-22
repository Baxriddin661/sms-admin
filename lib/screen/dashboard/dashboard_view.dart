import 'package:etcsms/screen/dashboard/widget/my_profile_widget.dart';
import 'package:etcsms/widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_bloc.dart';
import 'dashboard_event.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DashboardBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<DashboardBloc>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigoAccent[400],
        actions: [
          MyProfileWidget(userModel: bloc.sharedData.userModel!),
        ],
      ),
    );
  }
}
