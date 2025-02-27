import 'package:ecommerce_app/controllers/auth_service.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Profile",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
      scrolledUnderElevation: 0,
  forceMaterialTransparency: true,),
    body:  Column(children: [
      Consumer<UserProvider>(
        builder: (context, value, child) => 
        Card(
          child: ListTile(
            title: Text(value.name),
          subtitle:  Text(value.email),
          onTap: (){
            Navigator.pushNamed(context,"/update_profile");
          },
          trailing: const Icon(Icons.edit_outlined),
          ),
        ),
      ),
      const SizedBox(height: 20,),
      ListTile(title: const Text("Orders"), leading: const Icon(Icons.local_shipping_outlined), onTap: (){
        Navigator.pushNamed(context, "/orders");

      },),
      const Divider( thickness: 1,  endIndent:  10, indent: 10,),
      ListTile(title: const Text("Discount & Offers"), leading: const Icon(Icons.discount_outlined), onTap: (){
       Navigator.pushNamed(context, "/discount");
      },),
      const Divider( thickness: 1,  endIndent:  10, indent: 10,),
      ListTile(title: const Text("Helps & Support"), leading: const Icon(Icons.support_agent), onTap: (){
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mail us at amanchaudhary4510@gmail.com")));
      },),
      const Divider( thickness: 1,  endIndent:  10, indent: 10,),
      ListTile(title: const Text("Logout"), leading: const Icon(Icons.logout_outlined), onTap: ()async{
        Provider.of<UserProvider>(context,listen: false).cancelProvider();
        Provider.of<CartProvider>(context,listen: false).cancelProvider();
       await AuthService().logout();
       Navigator.pushNamedAndRemoveUntil(context,"/login", (route)=> true);
      },),
    ],),
    );
  }
}