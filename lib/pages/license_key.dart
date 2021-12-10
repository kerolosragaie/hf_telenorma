import 'package:flutter/material.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LicenseKey extends StatelessWidget {
  const LicenseKey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //This is the form that links the bloc with UI
    // InventoryCubit cubit = BlocProvider.of<InventoryCubit>(context,listen);
    return BlocConsumer<ShopsCubit, ShopsState>(
      listener: (context, state) {},
      builder: (context, state) => const Scaffold(),
    );
  }
}
