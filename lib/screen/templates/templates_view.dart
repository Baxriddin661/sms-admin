import 'package:etcsms/model/generic/filter_data.dart';
import 'package:etcsms/model/template_model.dart';
import 'package:etcsms/model/template_update_model.dart';
import 'package:etcsms/router/router.dart';
import 'package:etcsms/screen/templates/templates_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/app_table_widget.dart';
import '../../widget/app_text.dart';
import 'templates_bloc.dart';
import 'templates_event.dart';

class TemplatesPage extends StatefulWidget {
  final int applicationId;

  TemplatesPage({super.key, required this.applicationId});

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  int currentPage = 1;

  showButtons(BuildContext context, TemplatesBloc bloc, TemplateModel model) {
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
                  icon: Icon(
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
                                MaterialStateProperty.all(Size(120, 40)),
                            minimumSize:
                                MaterialStateProperty.all(Size(120, 40))),
                        onPressed: () {
                          bloc.add(UpdateTemplateEvent(TemplateUpdateModel(
                              id: model.id, status: "ACTIVE")));
                          Navigator.pop(context);
                          TemplateListingRoute(widget.applicationId).go;
                        },
                        child: AppText(
                          "Active",
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
                                MaterialStateProperty.all(const Size(120, 40)),
                            minimumSize:
                                MaterialStateProperty.all(const Size(120, 40))),
                        onPressed: () {
                          bloc.add(UpdateTemplateEvent(TemplateUpdateModel(
                              id: model.id, status: "INACTIVE")));
                          Navigator.pop(context);
                        },
                        child: AppText(
                          "InActive",
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

  showTemplateText(TemplateModel model) {
    Widget textRow({required String hintText, required String text}) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(5),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              hintText,
              color: Colors.grey,
            ),
            SizedBox(
              width: 20,
            ),
            AppText(text),
          ],
        ),
      );
    }

    showDialog(
        context: context,
        builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                width: 400,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textRow(
                      hintText: 'Id:',
                      text: model.id.toString(),
                    ),
                    textRow(
                      hintText: 'Status:',
                      text: model.status,
                    ),
                    textRow(
                      hintText: 'Type:',
                      text: model.type,
                    ),
                    textRow(
                      hintText: 'Abonent Id:',
                      text: model.abonentId.toString(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppText('Text:'),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Colors.blue.shade100,
                            color: Colors.white,
                            // border: Border.all(color: Colors.grey),

                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.grey,
                                  offset: Offset(2, 2))
                            ]),
                        child: AppText(model.text))
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TemplatesBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<TemplatesBloc>(context);
    return BlocConsumer<TemplatesBloc, TemplatesState>(
      builder: (context, state) => AppTableWidget<TemplateModel>(
        key: ValueKey(state.viewKey),
        listingApiCall: bloc.restClient.templateListing,
        configuration: AppTableConfiguration(
          title: "Templates for #${widget.applicationId} application",
          filterData: FilterData.defaultListing(size: 1000)
            ..applicationId = widget.applicationId,
          onBack: () {
            const ApplicationListingRoute().go(context);
          },
          buildTableRow: (data) {
            final model = data as TemplateModel;
            return DataRow(
              cells: [
                DataCell(AppText(model.id.toString())),
                DataCell(AppText(model.status,
                    color: model.status == 'ACTIVE'
                        ? Colors.green
                        : model.status == 'INACTIVE'
                            ? Colors.red
                            : Colors.grey)),
                DataCell(AppText(model.type)),
                DataCell(AppText(model.abonentId.toString())),
                DataCell(ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Change the radius here
                      ))),
                  // shadowColor: Colors.transparent,

                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: Colors.white,
                  //   // shadowColor: Colors.transparent,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius:
                  //         BorderRadius.circular(10), // Change the radius here
                  //   ),
                  // ),
                  onPressed: () {
                    showTemplateText(model);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(color: Colors.white),
                      child: AppText(
                        model.text ?? '',
                        textOverflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        color: Colors.red,
                      )),
                )),
                DataCell(AppText(model.createdAt ?? 'N/A')),
                if (bloc.sharedData.userModel!.roleId == 1) ...{
                  DataCell(IconButton(
                      onPressed: () {
                        showButtons(context, bloc, model);
                      },
                      icon: const Icon(Icons.info)))
                } else ...{
                  const DataCell(SizedBox())
                },
              ],
            );
          },
          columnConfiguration: [
            ColumnConfiguration(label: "ID", dataKey: 'id', sortable: false),
            ColumnConfiguration(
                label: "Status", dataKey: 'status', sortable: false),
            ColumnConfiguration(
                label: "Type", dataKey: 'type', sortable: false),
            ColumnConfiguration(
                label: "Abonent ID", dataKey: 'abonentID', sortable: false),
            ColumnConfiguration(
                label: "Text", dataKey: 'text', sortable: false),
            ColumnConfiguration(
                label: "Created At", dataKey: 'createdAt', sortable: false),
            if (bloc.sharedData.userModel!.roleId == 1) ...{
              ColumnConfiguration(
                  label: "Change status",
                  dataKey: 'statusChange',
                  sortable: false)
            } else ...{
              ColumnConfiguration(label: "", dataKey: '', sortable: false)
            },
          ],
        ),
      ),
      listener: (context, state) {},
    );
  }
}
