import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:hf/business_logic_layer/cubit/bestellung_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/inventur_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/teil_inventur_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/umlagerung_artikel_cubit.dart';
import 'package:hf/business_logic_layer/cubit/ware_cubit.dart';
import 'package:hf/business_logic_layer/cubit/ware_states.dart';
import 'package:hf/business_logic_layer/cubit/wareneingang_artikel_cubit.dart';
import 'package:hf/data_layer/api/bestellung_artikel_services.dart';
import 'package:hf/data_layer/api/inventur_artikel_services.dart';
import 'package:hf/data_layer/api/teil_inventur_artikel_services.dart';
import 'package:hf/data_layer/api/umlagerung_artikel_services.dart';
import 'package:hf/data_layer/api/ware.dart';
import 'package:hf/data_layer/api/wareneingang_artikel_services.dart';
import 'package:hf/data_layer/models/ware.dart';
import 'package:hf/data_layer/repository/bestellung_artikel_repository.dart';
import 'package:hf/data_layer/repository/inventur_artikel_repository.dart';
import 'package:hf/data_layer/repository/teil_inventur_artikel_repository.dart';
import 'package:hf/data_layer/repository/umlagerung_artikel_repository.dart';
import 'package:hf/data_layer/repository/ware_repository.dart';
import 'package:hf/data_layer/repository/wareneingang_artikel_repository.dart';
import 'package:hf/presentation_layer/screens/bestellung_artikel_screen.dart';
import 'package:hf/presentation_layer/screens/teilinventur_artikel_screen.dart';
import 'package:hf/presentation_layer/screens/umlagerung_artikel_screen.dart';
import 'package:hf/presentation_layer/screens/wareneingang_artikel_screen.dart';
import 'package:hf/presentation_layer/widgets/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

import 'inventur_artikel_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key, this.currItem, this.type});
  final dynamic currItem;
  final String? type;

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  WareRepository wareRepository = WareRepository(WareServices());

  TeilInventurArtikelRepository teilInventurArtikelRepository =
      TeilInventurArtikelRepository(TeilInventurArtikelServices());
  InventurArtikelRepository inventurArtikelRepository =
      InventurArtikelRepository(InventurArtikelServices());
  WareneingangArtikelRepository wareneingangArtikelRepository =
      WareneingangArtikelRepository(WareneingangArtikelServices());
  UmlagerungArtikelRepository umlagerungArtikelRepository =
      UmlagerungArtikelRepository(UmlagerungArtikelServices());
  BestellungArtikelRepository bestellungArtikelRepository =
      BestellungArtikelRepository(BestellungArtikelServices());

  @override
  Widget build(BuildContext context) {
    void _onQRViewCreated(QRViewController controller) {
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) {
        setState(() {
          result = scanData;
          BlocProvider.of<WareCubit>(context).getWare(barCode: result?.code);
        });
      });
    }

    return Scaffold(
      appBar: AppBarPro(
        addBackButton: true,
        actions: [
          //TODO: add functionallty here:
          IconButton(
            iconSize: 24,
            icon: Icon(
              Icons.e_mobiledata,
              color: HexColor("424D51"),
            ),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 24,
            icon: Icon(
              Icons.check,
              color: HexColor("424D51"),
            ),
            onPressed: () {
              Map<String, dynamic> data = {
                'inventur_id': widget.currItem!.id,
                'artikel': BlocProvider.of<WareCubit>(context).ware[0].artikel,
                'product': BlocProvider.of<WareCubit>(context).ware[0].product,
                'kasse_id': BlocProvider.of<WareCubit>(context).ware[0].kasseId,
                'menge': BlocProvider.of<WareCubit>(context).menge,
                'vk': BlocProvider.of<WareCubit>(context).ware[0].vk! *
                    BlocProvider.of<WareCubit>(context).menge,
                'ean': BlocProvider.of<WareCubit>(context).ware[0].ean,
              };

              if (widget.type == 'teil-inventur') {
                teilInventurArtikelRepository
                    .addTeilInventurArtikel(data)
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => TeilInventurArtikelCubit(
                                teilInventurArtikelRepository),
                            child: TeilInventurArtikelScreen(
                              currTeilInventur: widget.currItem,
                            ),
                          )));
                });
              } else if (widget.type == "Inventur") {
                inventurArtikelRepository
                    .addInventurArtikel(data)
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) =>
                                InventurArtikelCubit(inventurArtikelRepository),
                            child: InventurArtikelScreen(
                              currInventur: widget.currItem,
                            ),
                          )));
                });
              } else if (widget.type == "wareneingang") {
                wareneingangArtikelRepository
                    .addWareneingangArtikel(data)
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => WareneingangArtikelCubit(
                                wareneingangArtikelRepository),
                            child: WareneingangArtikelScreen(
                              currWareneingang: widget.currItem,
                            ),
                          )));
                });
              } else if (widget.type == "umlagerung") {
                Map<String, dynamic> umlagerungData = {
                  'umlagerung_id': widget.currItem!.id,
                  'artikel':
                      BlocProvider.of<WareCubit>(context).ware[0].artikel,
                  'product':
                      BlocProvider.of<WareCubit>(context).ware[0].product,
                  'kasse_id':
                      BlocProvider.of<WareCubit>(context).ware[0].kasseId,
                  'menge': BlocProvider.of<WareCubit>(context).menge,
                  'vk': BlocProvider.of<WareCubit>(context).ware[0].vk! *
                      BlocProvider.of<WareCubit>(context).menge,
                  'ean': BlocProvider.of<WareCubit>(context).ware[0].ean,
                };

                umlagerungArtikelRepository
                    .addUmlagerungArtikel(umlagerungData)
                    .then((value) {
                  print(value);
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => UmlagerungArtikelCubit(
                                umlagerungArtikelRepository),
                            child: UmlagerungArtikelScreen(
                              currUmlagerung: widget.currItem,
                            ),
                          )));
                });
              } else if (widget.type == "bestellung") {
                Map<String, dynamic> bestellungData = {
                  'bestellung_id': widget.currItem!.id,
                  'artikel':
                      BlocProvider.of<WareCubit>(context).ware[0].artikel,
                  'product':
                      BlocProvider.of<WareCubit>(context).ware[0].product,
                  'kasse_artikel_id':
                      BlocProvider.of<WareCubit>(context).ware[0].kasseId,
                  'kasse': BlocProvider.of<WareCubit>(context).ware[0].kasseId,
                  'menge': BlocProvider.of<WareCubit>(context).menge,
                  'vk': BlocProvider.of<WareCubit>(context).ware[0].vk! *
                      BlocProvider.of<WareCubit>(context).menge,
                  'ean': BlocProvider.of<WareCubit>(context).ware[0].ean,
                };

                bestellungArtikelRepository
                    .addBestellungArtikel(bestellungData)
                    .then((value) {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => BestellungArtikelCubit(
                                bestellungArtikelRepository),
                            child: BestellungArtikelScreen(
                              currBestellung: widget.currItem,
                            ),
                          )));
                });
              } else {
                print('${widget.type}');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: QRView(
              overlay: QrScannerOverlayShape(
                borderColor: HexColor("5E5E5F"),
                borderWidth: 8,
              ),
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          //TODO: + and - buttons with card view data:
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          child: IconButton(
                            onPressed: () {
                              BlocProvider.of<WareCubit>(context)
                                  .increaseMenge();
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                BlocProvider.of<WareCubit>(context)
                                    .decreaseMenge();
                              });
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //TODO: create a stless model and view on it:
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const _DataViewer(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataViewer extends StatelessWidget {
  final String productArtikel = '';

  const _DataViewer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WareCubit, WareStates>(builder: (context, wareState) {
      List<Ware> wareData = BlocProvider.of<WareCubit>(context).ware;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocProvider.of<WareCubit>(context).ware.isNotEmpty
              ? Text(
                  "${BlocProvider.of<WareCubit>(context).ware[0].artikel}: ${BlocProvider.of<WareCubit>(context).ware[0].product}",
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : Text('Empty'),
          Text(
            "Price: ${BlocProvider.of<WareCubit>(context).ware.isNotEmpty ? wareData[0].vk! * BlocProvider.of<WareCubit>(context).menge : '0'}",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            "HF: 0",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            "Menge: ${BlocProvider.of<WareCubit>(context).menge}",
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    });
  }
}
