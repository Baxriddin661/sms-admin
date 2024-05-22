import 'package:etcsms/model/user_model.dart';
import 'package:etcsms/screen/users/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../model/generic/filter_data.dart';
import '../../widget/app_drawer.dart';
import '../../widget/app_table_widget.dart';
import '../../widget/app_text.dart';
import '../users/users_event.dart';
import '../dashboard/widget/my_profile_widget.dart';

class UsersPage extends StatefulWidget {
  UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  int numberOfPages = 10;
  int currentPage = 1;
  var numberOfPaginationController = NumberPaginatorController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UsersBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  int userLength = 360;

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<UsersBloc>(context);

    final List<String> statuses = [
      'ACCEPTED',
      'REJECTED',
      'CHECKING',
      'WITH_COMMENTS',
      'SENT'
    ];

    var pages = List.generate(numberOfPages,
        (index) => _pageinatorPage(context: context, bloc: bloc));

    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.indigoAccent[400],
          title: AppText(
            'Users',
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
        body: Column(
          children: [
            Expanded(child: pages[currentPage]),
          ],
        ));
  }

  Widget _pageinatorPage(
      {required BuildContext context, required UsersBloc bloc}) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: AppTableWidget<UserModel>(
          key: ValueKey(bloc.state.viewKey),
          listingApiCall: bloc.restClient.usersList,
          configuration: AppTableConfiguration(
            withDrawer: false,
            filterData: FilterData.defaultListing(page: currentPage, size: 10),
            buildTableRow: (data) {
              final model = data as UserModel;
              return DataRow(
                cells: [
                  const DataCell(Icon(
                    Icons.person,
                    size: 40,
                  )),
                  DataCell(Text(model.id.toString())),
                  DataCell(Text(model.name ?? 'N/A')),
                  DataCell(Text(model.login.toString())),
                  DataCell(Text(model.emailAddress ?? '')),
                  DataCell(Text(model.roleId == 1 ? 'Admin' : 'User')),
                ],
              );
            },
            columnConfiguration: [
              ColumnConfiguration(
                  label: "User", dataKey: 'id', sortable: false),
              ColumnConfiguration(label: "Id", dataKey: 'id', sortable: false),
              ColumnConfiguration(
                  label: "Name", dataKey: 'name', sortable: false),
              // ColumnConfiguration(label: "Type", dataKey: 'type', sortable: false),
              ColumnConfiguration(
                  label: "Login", dataKey: 'login', sortable: false),
              ColumnConfiguration(
                  label: "Email address",
                  dataKey: 'emailAddress',
                  sortable: false),
              ColumnConfiguration(
                  label: "Role", dataKey: 'role', sortable: false),
            ],
          ),
        ),
      ),
    );
  }
}
