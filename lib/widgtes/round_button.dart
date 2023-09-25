import 'package:flutter/material.dart';
import 'package:online_store/widgtes/colors.dart';
class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool loading;
  const RoundButton({Key? key, required this.title , required this.ontap,this.loading=false, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: AppColors.pinkShade2,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(child:loading ? CircularProgressIndicator(strokeWidth: 4,color: Colors.white,): Text(title,style: TextStyle(color: Colors.white),)),
        ),
      ),
    );
  }
}
class Categories extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  const Categories({Key? key, required this.title , required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              color: AppColors.pinkShade2,
              borderRadius: BorderRadius.circular(20)
          ),
          child:Text(title,style: TextStyle(color: Colors.white),)),
        ),
      );}}
class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  const MyButton({Key? key, required this.title , required this.ontap, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Center(
        child: Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(child: Text(title,style: TextStyle(color: AppColors.pink,fontSize: 15),)),
        ),
      ),
    );
  }
}

