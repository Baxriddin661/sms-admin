import 'package:etcsms/model/generic/filter_data.dart';
import 'package:etcsms/screen/applications/applications_state.dart';
import 'package:etcsms/widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/application_model.dart';
import '../../model/application_update_model.dart';
import '../../router/router.dart';
import '../../widget/app_drawer.dart';
import '../../widget/app_table_widget.dart';
import '../dashboard/widget/my_profile_widget.dart';

import 'applications_bloc.dart';
import 'applications_event.dart';

class ApplicationsPage extends StatelessWidget {
  final commentController = TextEditingController();

  ApplicationsPage({super.key});

  showButtons(
      BuildContext context, ApplicationsBloc bloc, ApplicationModel model) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 350,
          height: 150,
          padding: EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(1.5, -2),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.white.withOpacity(0.5)),
                    maximumSize: MaterialStateProperty.all(Size(40, 40)),
                    // minimumSize: MaterialStateProperty.all(Size(20, 20))
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(
                    'Change template status',
                    size: 25,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            maximumSize:
                                MaterialStateProperty.all(Size(150, 40)),
                            minimumSize:
                                MaterialStateProperty.all(Size(150, 40))),
                        onPressed: () {
                          bloc.add(UpdateApplicationEvent(
                              ApplicationUpdateModel(
                                  id: model.id,
                                  status: "ACCEPTED",
                                  comment: '')));
                          Navigator.pop(context);
                        },
                        child: AppText(
                          "ACCEPTED",
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            maximumSize:
                                MaterialStateProperty.all(const Size(150, 40)),
                            minimumSize:
                                MaterialStateProperty.all(const Size(150, 40))),
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  child: Container(
                                      width: 350,
                                      height: 300,
                                      padding: EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Stack(children: [
                                        Align(
                                          alignment: Alignment(1.4, -1.5),
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white
                                                          .withOpacity(0.5)),
                                              maximumSize:
                                                  MaterialStateProperty.all(
                                                      Size(40, 40)),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            AppText(
                                              'Add any comment:',
                                              size: 25,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            Spacer(),
                                            TextField(
                                              controller: commentController,
                                              maxLines: 5,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)))),
                                            ),
                                            Spacer(),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  maximumSize:
                                                      MaterialStateProperty.all(
                                                          const Size(150, 40)),
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                          const Size(150, 40))),
                                              onPressed: () {
                                                bloc.add(UpdateApplicationEvent(
                                                    ApplicationUpdateModel(
                                                        id: model.id,
                                                        status: "REJECTED",
                                                        comment: commentController
                                                                    .text ==
                                                                ''
                                                            ? 'No Comment'
                                                            : commentController
                                                                .text)));
                                                commentController.clear();
                                                Navigator.pop(context);
                                              },
                                              child: AppText(
                                                "SENT",
                                                color: Colors.green,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        )
                                      ])));
                            },
                          );
                        },
                        child: AppText(
                          "REJECTED",
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ApplicationsBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ApplicationsBloc>(context);

    final List<String> statuses = [
      'ACCEPTED',
      'REJECTED',
      // 'CHECKING',
      // 'WITH_COMMENTS',
      'SENT'
    ];

    return BlocConsumer<ApplicationsBloc, ApplicationsState>(
      builder: (context, state) {
        return Scaffold(
          key: ValueKey(state.viewKey),
          drawer: const AppDrawer(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.indigoAccent[400],
            title: AppText(
              'Applications',
              color: Colors.white,
            ),
            leading: Builder(
                builder: (context) => IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: Icon(Icons.list, color: Colors.white,))),
            actions: [
              MyProfileWidget(userModel: bloc.sharedData.userModel!),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ApplicationCreateRoute().go(context);
            },
            backgroundColor: Colors.indigo,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: DefaultTabController(
            length: statuses.length,
            child: Column(
              children: [
                Container(
                  color: Colors.indigoAccent.withOpacity(.2),
                  child: TabBar(
                    indicatorColor: Colors.indigo,
                    indicatorWeight: 5,
                    labelColor: Colors.indigo,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: [
                      for (final status in statuses) ...{
                        Tab(
                          text: status,
                        )
                      }
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      for (final status in statuses) ...{
                        AppTableWidget<ApplicationModel>(
                          listingApiCall:
                              bloc.restClient.applicationsListByStatus,
                          configuration: AppTableConfiguration(
                            withDrawer: false,
                            filterData: FilterData.defaultListing()
                              ..status = status ?? 'No',
                            buildTableRow: (data) {
                              final model = data as ApplicationModel;
                              return DataRow(
                                cells: [
                                  DataCell(AppText(model.id.toString())),
                                  DataCell(AppText(
                                    model.status ?? 'N/A',
                                    color: model.status == 'ACCEPTED'
                                        ? Colors.green
                                        : model.status == 'REJECTED'
                                            ? Colors.red
                                            : Colors.grey,
                                  )),
                                  // DataCell(AppText(model.type)),
                                  DataCell(AppText(model.abonentId.toString())),
                                  DataCell(
                                      AppText(model.comment ?? 'No Comment')),
                                  DataCell(AppText(model.createdAt ?? 'N/A')),
                                  DataCell(
                                    IconButton(
                                      onPressed: () {
                                        TemplateListingRoute(model.id)
                                            .go(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                  if (bloc.sharedData.userModel!.roleId ==
                                      1) ...{
                                    DataCell(IconButton(
                                        onPressed: () {
                                          showButtons(context, bloc, model);
                                        },
                                        icon: const Icon(Icons.info)))
                                  } else ...{
                                    DataCell(SizedBox())
                                  }
                                ],
                              );
                            },
                            columnConfiguration: [
                              ColumnConfiguration(
                                  label: "ID", dataKey: 'id', sortable: false),
                              ColumnConfiguration(
                                  label: "Status",
                                  dataKey: 'status',
                                  sortable: false),
                              // ColumnConfiguration(label: "Type", dataKey: 'type', sortable: false),
                              ColumnConfiguration(
                                  label: "Abonent ID",
                                  dataKey: 'abonentID',
                                  sortable: false),
                              ColumnConfiguration(
                                  label: "Comment",
                                  dataKey: 'comment',
                                  sortable: false),
                              ColumnConfiguration(
                                  label: "Created At",
                                  dataKey: 'createdAt',
                                  sortable: false),
                              ColumnConfiguration(
                                  label: "Details",
                                  dataKey: 'details',
                                  sortable: false),
                              if (bloc.sharedData.userModel!.roleId == 1) ...{
                                ColumnConfiguration(
                                    label: "Change status",
                                    dataKey: 'statusChange',
                                    sortable: false)
                              } else ...{
                                ColumnConfiguration(
                                    label: "", dataKey: '', sortable: false)
                              }
                            ],
                          ),
                        )
                      }
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) => {},
    );
  }
}
