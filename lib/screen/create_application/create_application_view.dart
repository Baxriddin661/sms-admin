import 'package:etcsms/router/router.dart';
import 'package:etcsms/screen/create_application/widget/add_template_dialog.dart';
import 'package:etcsms/screen/create_application/widget/template_item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/app_text.dart';
import 'create_application_bloc.dart';
import 'create_application_event.dart';
import 'create_application_state.dart';

class CreateApplicationPage extends StatefulWidget {
  @override
  State<CreateApplicationPage> createState() => _CreateApplicationPageState();
}

class _CreateApplicationPageState extends State<CreateApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          CreateApplicationBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<CreateApplicationBloc>(context);

    return BlocConsumer(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                if (bloc.state.templates.length > 0) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            width: 350,
                            height: 130,
                            padding: EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white.withOpacity(0.5)),
                                      maximumSize: MaterialStateProperty.all(
                                          Size(40, 40)),
                                      // minimumSize: MaterialStateProperty.all(Size(20, 20))
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AppText(
                                      'Save and send application ?',
                                      size: 25,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              maximumSize:
                                                  MaterialStateProperty.all(
                                                      Size(120, 40)),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size(120, 40))),
                                          onPressed: () {
                                            // bloc.add(UpdateTemplateEvent(TemplateUpdateModel(
                                            //     id: model.id, status: "ACTIVE")));
                                            bloc.add(SubmitApplicationEvent());
                                            // TemplateListingRoute(widget.applicationId).go;
                                          },
                                          child: AppText(
                                            "SEND",
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
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              maximumSize:
                                                  MaterialStateProperty.all(
                                                      const Size(120, 40)),
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      const Size(120, 40))),
                                          onPressed: () {
                                            // Navigator.pop(context);
                                            ApplicationListingRoute()
                                                .go(context);
                                          },
                                          child: AppText(
                                            "No",
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
                        );
                      });
                } else {
                  ApplicationListingRoute().go(context);
                }
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.indigo,
            title: AppText(
              'Create new appliction',
              size: 20,
              color: Colors.white,
            ),
            actions: [
              SizedBox(
                width: 20,
              ),
              IconButton(
                tooltip: 'Create application with added templates',
                onPressed: () {
                  bloc.add(SubmitApplicationEvent());
                },
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  width: double.infinity,
                  child: Wrap(
                    spacing: 0,
                    runSpacing: 8,
                    children: List.generate(
                      bloc.state.templates.length,
                      (index) => TemplateItemCardWidget(
                        model: bloc.state.templates[index],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                backgroundColor: Colors.indigo,
                onPressed: () {
                  showAddTemplateDialog(context, (value) {
                    bloc.add(AddTemplateEvent(value));
                  });
                },
                label: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AppText(
                      'Add new template',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {
        if (state is ApplicationCreatedState) {
          ApplicationListingRoute().go(context);
        }
      },
    );
  }
}
