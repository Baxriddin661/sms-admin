import 'package:etcsms/manager/loader_manager.dart';
import 'package:etcsms/manager/locator.dart';
import 'package:etcsms/model/generic/filter_data.dart';
import 'package:etcsms/model/generic/listing_response_model.dart';
import 'package:etcsms/widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

typedef SingTableItemSelectorCallback<T> = void Function(dynamic data);
typedef ListingApiCall<T> = Future<ListingResponseModel<T>> Function(
    Map<String, dynamic> queries);
typedef BuildTableRow<T> = DataRow Function(dynamic data);

class AppTableConfiguration<T> {
  final String? title;
  final List<ColumnConfiguration> columnConfiguration;
  final BuildTableRow<T> buildTableRow;
  final VoidCallback? onAddTap;
  final VoidCallback? onBack;
  final SingTableItemSelectorCallback<T>? onUpdate;
  final SingTableItemSelectorCallback<T>? onDelete;
  final bool withSearch;
  final FilterData? filterData;
  final bool withDrawer;

  AppTableConfiguration({
    this.title,
    required this.buildTableRow,
    required this.columnConfiguration,
    this.withSearch = false,
    this.withDrawer = true,
    this.onUpdate,
    this.onDelete,
    this.onAddTap,
    this.filterData,
    this.onBack,
  });

  bool get _hasExtraAction {
    return onUpdate != null || onDelete != null;
  }
}

class ColumnConfiguration {
  final String label;
  final String dataKey;
  final bool sortable;

  ColumnConfiguration(
      {required this.label, required this.dataKey, required this.sortable});
}

class AppTableWidget<T> extends StatefulWidget {
  AppTableWidget(
      {super.key,
      required this.listingApiCall,
      required this.configuration,
      });


  final ListingApiCall<T> listingApiCall;
  final AppTableConfiguration<T> configuration;

  @override
  State<AppTableWidget> createState() => _AppTableWidgetState<T>();
}

class _AppTableWidgetState<T> extends State<AppTableWidget> {
  LoaderManager loaderManager = locator.get<LoaderManager>();
  late FilterData filterData =
      widget.configuration.filterData ?? FilterData.defaultListing();
  int numberOfPages = 1;
  List<T> data = [];

  _fetch() async {
    loaderManager.showLoader();
    final ListingResponseModel<T> responseData = (await widget
        .listingApiCall(filterData.toJson())) as ListingResponseModel<T>;
    loaderManager.hideLoader();
    setState(() {
      data = responseData.content ?? [];
      numberOfPages = responseData.totalPages;
      numberOfPages == 0 ? numberOfPages = 1 : numberOfPages;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: widget.configuration.title == null
          ? null
          : AppBar(
              backgroundColor: Colors.indigoAccent,
              leading: widget.configuration.onBack != null
                  ? IconButton(
                      onPressed: widget.configuration.onBack,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )
                  : null,
              title: Text(
                widget.configuration.title!,
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                if (widget.configuration.withSearch) ...{
                  Container(
                    width: 400,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: TextField(
                      onSubmitted: (value) {
                        filterData.search = value;
                        _fetch();
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                },
                if (widget.configuration.onAddTap != null) ...{
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: IconButton(
                      onPressed: widget.configuration.onAddTap,
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                },
              ],
            ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      child: DataTable(
                        headingRowColor: MaterialStatePropertyAll(
                            Colors.grey.withOpacity(.2)),
                        columns: [
                          ...widget.configuration.columnConfiguration.map(
                            (e) => DataColumn(
                              label: Text(
                                e.label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              numeric: false,
                              onSort: e.sortable
                                  ? (columnIndex, ascending) {}
                                  : null,
                            ),
                          ),
                          if (widget.configuration._hasExtraAction) ...{
                            DataColumn(
                              label: Text(
                                "Action",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              numeric: false,
                            )
                          }
                        ],
                        rows: [
                          ...data.map((e) {
                            if (widget.configuration._hasExtraAction) {
                              return widget.configuration.buildTableRow(e)
                                ..cells.add(
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (widget.configuration.onUpdate !=
                                            null) ...{
                                          IconButton(
                                              onPressed: () => widget
                                                  .configuration.onUpdate!(e),
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.indigo,
                                              ))
                                        },
                                        SizedBox(
                                          width: 10,
                                        ),
                                        if (widget.configuration.onDelete !=
                                            null) ...{
                                          IconButton(
                                              onPressed: () => widget
                                                  .configuration.onDelete!(e),
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ))
                                        },
                                      ],
                                    ),
                                  ),
                                );
                            } else {
                              return widget.configuration.buildTableRow(e);
                            }
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width / 2.5,
              child: NumberPaginator(
                // controller: numberOfPaginationController,
                numberPages: numberOfPages,
                onPageChange: (index) {

                    filterData.page = index + 1;
                    _fetch();

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
