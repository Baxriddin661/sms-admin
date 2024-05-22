import 'package:etcsms/widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../router/router.dart';
import '../screen/templates/templates_event.dart';
import '../screen/templates/templates_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => TemplatesBloc()..add(InitEvent()),
        child: Builder(builder: (context) {
          final bloc = BlocProvider.of<TemplatesBloc>(context);

          return Container(
            color: Colors.indigoAccent,
            width: 200,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Image.asset('assets/images/et.png',width: 80,),AppText('ETC SMS', size: 30 , color: Colors.white,fontWeight: FontWeight.w700,),

SizedBox(height: 20,),

                ListTile(
                  onTap: () {
                    ApplicationListingRoute().go(context);
                  },
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  titleAlignment: ListTileTitleAlignment.threeLine,
                  title: Text(
                    "Applications",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (bloc.sharedData.userModel!.roleId == 1) ...{
                  ListTile(
                    onTap: () {
                      UsersListingRoute().go(context);
                    },
                    leading: Icon(
                      Icons.list_alt,
                      color: Colors.white,
                    ),
                    titleAlignment: ListTileTitleAlignment.threeLine,
                    title: Text(
                      "Users list",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                } else ...{
                  SizedBox()
                }
                , ListTile(
                  onTap: () {
                    MyProfileListingRoute().go(context);
                  },
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  titleAlignment: ListTileTitleAlignment.threeLine,
                  title: Text(
                    "My Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),


              ],
            ),
          );
        }));
  }
}
