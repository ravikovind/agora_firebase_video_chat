import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call/provider/user_provider.dart';
import 'package:video_call/utils/universal_variables.dart';
import 'package:video_call/utils/utilities.dart';
import 'user_details_container.dart';

class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white24,
        builder: (context) => UserDetailsContainer(),
      ),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: UniversalVariables.separatorColor,
        ),
        child: Center(
          child: Text(
            Utils.getInitials(userProvider.getUser.name),
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.redAccent,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
