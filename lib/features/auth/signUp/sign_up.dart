import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:el_bershama/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;

 
  @override
  void initState(){
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();

    super.initState();

  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorsManger.withColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Image.asset('images/part bershama.png'),
               Text('انشاء حساب',style: StylesManger.black50Bold,),
                CustomTextField(  isPassword: false, hint: 'الاسم', icon:Icons.person ,),
                CustomTextField(  isPassword: false, hint: 'البريد', icon:Icons.email) ,
                CustomTextField(  isPassword: true, hint: 'كلمة المرور', icon:Icons.lock ,),
                SizedBox(height: 35,),
                ButtonWidget(onpress: (){
                  Navigator.pushReplacementNamed(context, 'Home');
                }, 
                text: 'انشاء حساب'),
                SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, 'login') ;
                      
                    }, 
                    child: Text('سجل دخولك',style: StylesManger.titleText20Style,)),
                    Text('لديك حساب بالفعل ؟', style: StylesManger.titleText20Style,)
                  ],
                )
                
              ],
              
            ),
          ),
        ),
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {



   final bool isPassword;
    final IconData icon;
  final String hint;
  const CustomTextField(
    {super.key,   required this.isPassword, required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: TextEditingController(),
        textDirection: TextDirection.rtl, 
         textAlign: TextAlign.right,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
       );
  }
}