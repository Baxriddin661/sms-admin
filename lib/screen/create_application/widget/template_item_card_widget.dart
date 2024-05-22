import 'package:etcsms/model/template_create_model.dart';
import 'package:etcsms/widget/app_text.dart';
import 'package:flutter/material.dart';

/**
 * Created by Bekhruz Makhmudov on 06/05/24.
 * Project sms_etc_admin
 */
class TemplateItemCardWidget extends StatelessWidget {
  const TemplateItemCardWidget({Key? key, required this.model})
      : super(key: key);
  final TemplateCreateModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      constraints: BoxConstraints(
        maxWidth: 400,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.indigoAccent.shade100,
            blurRadius: 4,
          )
        ],
        // border: Border.all(color: Colors.indigo),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: AppText(
                  model.type,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(15),
              child: AppText(model.text)),
        ],
      ),
    );
  }
}
