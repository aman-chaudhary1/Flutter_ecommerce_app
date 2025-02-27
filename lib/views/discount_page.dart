import 'package:ecommerce_app/controllers/db_service.dart';
import 'package:ecommerce_app/models/coupon_model.dart';
import 'package:flutter/material.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Discount Coupons",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),  scrolledUnderElevation: 0,
  forceMaterialTransparency: true,),
    body: StreamBuilder(stream: DbService().readDiscounts(), builder: (context,snapshot){
      if(snapshot.hasData){
        List<CouponModel> discounts= CouponModel.fromJsonList(snapshot.data!.docs);

        if(discounts.isEmpty){
          return const SizedBox();
        }
        else{
          return ListView.builder(itemCount: discounts.length,itemBuilder: (context, index){
            return ListTile(
              leading:  const Icon(Icons.discount_outlined),
              title: Text(discounts[index].code),
              subtitle:  Text(discounts[index].desc),
            );
          });
          
        }

      }
      else{
        return const SizedBox();
      }
    })

    );
  }
}