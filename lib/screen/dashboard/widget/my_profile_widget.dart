import 'package:flutter/material.dart';
import 'package:etcsms/manager/local_storage_manager.dart';
import 'package:etcsms/manager/locator.dart';
import 'package:etcsms/model/user_model.dart';
import 'package:etcsms/router/router.dart';



class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  logOut(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Attention'),
          content: Text('Are you going to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                var localStorageManager = locator.get<LocalStorageManager>();
                await localStorageManager.deleteToken();
                await locator.reset();
                setupLocator();
                LoginScreenRoute().go(context);
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => logOut(context),
      child: Card(
        color: Colors.indigoAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Text(
              userModel.name ?? '',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(Icons.logout, color: Colors.white),
            SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
