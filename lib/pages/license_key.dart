
import 'package:flutter/material.dart';
import 'package:hf/business_logic_layer/cubit/inventory_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LicenseKey extends StatelessWidget {
  const LicenseKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //This is the form that links the bloc with UI
    // InventoryCubit.get(context);
    return  BlocConsumer<InventoryCubit,InventoryState>(
      listener: (context, state){
      },
      builder: (context, state) => Scaffold(),
    );

  }
}
