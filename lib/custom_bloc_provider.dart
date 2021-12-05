import 'package:flutter/material.dart';
import 'package:hf/app_router.dart';
import 'package:hf/business_logic_layer/cubit/inventory_cubit.dart';
import 'package:hf/data_layer/api/shop_api.dart';
import 'package:hf/data_layer/repository/shops_repository.dart';
import 'package:hf/main.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    /*ShopsRepository shopsRepository;
    InventoryCubit inventoryCubit;*/
    return MultiBlocProvider(providers: [
      BlocProvider<InventoryCubit>(create: (context) => InventoryCubit(ShopsRepository(ShopApi())),)
    ], child: HF(appRouter: AppRouter(),),

    );
  }
}
