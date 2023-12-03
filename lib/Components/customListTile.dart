import 'package:almeerah/Components/customTextstyle.dart';
import 'package:flutter/material.dart';
class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String pageName;
  final String pageRouteName;
  const CustomListTile({super.key,
    required this.icon,
    required this.pageName,
    required this.pageRouteName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(pageName,style: CustomTextStyles.paragraphTextStyle(context),),
      onTap: (){
        Navigator.pushReplacementNamed(context, pageRouteName);
      },
    );
  }
}
