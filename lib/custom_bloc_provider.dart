import 'package:flutter/material.dart';
import 'package:hf/app_router.dart';
import 'package:hf/business_logic_layer/cubit/shops_cubit.dart';
import 'package:hf/data_layer/api/shops_services.dart';
import 'package:hf/data_layer/repository/shops_repository.dart';
import 'package:hf/main.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*ShopsRepository shopsRepository;
    InventoryCubit inventoryCubit;*/
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShopsCubit>(
          create: (context) => ShopsCubit(ShopsRepository(ShopServices())),
        )
      ],
      child: HF(
        appRouter: AppRouter(),
      ),
    );
  }
}
