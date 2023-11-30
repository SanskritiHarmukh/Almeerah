import 'package:almeerah/Components/customTextstyle.dart';
import 'package:almeerah/Components/customcontainer.dart';
import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final String categoryName;
  final IconData icon;
  final String pageName;
  const CategoryContainer({super.key,
    required this.categoryName,
    required this.icon,
    required this.pageName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, pageName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomContainer(
                    child: Icon(icon,size: 28,weight: .5,),
                width: 64,
                hpad: 0,
                vpad: 16,),
                SizedBox(height: 8,),
                Text(categoryName,style: CustomTextStyles.categoryTextStyle(context),)
              ],
            ),
            )
      ),
    );
  }
}
