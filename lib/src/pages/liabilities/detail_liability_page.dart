import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/data/models/Liability.dart';
import 'package:paymentsapp/src/widgets/background_app.dart';
import 'package:paymentsapp/src/widgets/background_card.dart';
import 'package:paymentsapp/src/widgets/card_cuenta_origen.dart';
import 'package:paymentsapp/src/widgets/icon_send_widget.dart';
import 'package:paymentsapp/src/widgets/toolBar_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class DetailLiabilityPage extends StatefulWidget {
  final Liability? liability;
  const DetailLiabilityPage({super.key, this.liability});

  @override
  State<DetailLiabilityPage> createState() => _DetailLiabilityPageState();
}

class _DetailLiabilityPageState extends State<DetailLiabilityPage> {
  final controller = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Detalle de deuda"),
      body: Stack(
        children: <Widget>[
          skinApp(),
          //_iconPage(),
          Screenshot(
            controller: controller,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 100.0, bottom: 170.0, left: 20.0, right: 20.0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 8.0,
                child: Stack(
                  children: <Widget>[
                    backgroundCard(),
                    voucher(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.share_outlined),
                            color: Colors.blue[700],
                            onPressed: () async {
                              final image =
                                  await controller.captureFromWidget(voucher());
                              saveAndShare(image);
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container voucher() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Column(
        children: <Widget>[
          iconSend(),
          const SizedBox(height: 20.0),
          RichText(
              text: TextSpan(children: [
            /*TextSpan(
                              text: 'Envio exitoso a ',
                              style: TextStyle(
                                  color: colorTextoSecundario, fontSize: 12.0)),*/
            TextSpan(
                text: widget.liability?.description,
                style: const TextStyle(
                    color: colorTextoTitulo,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0))
          ])),
          const SizedBox(height: 10.0),
          Text(
              NumberFormat.currency(symbol: '\$ ', decimalDigits: 0)
                  .format(double.parse(widget.liability?.amount ?? '0')),
              style: const TextStyle(
                  color: colorPrimario,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 15.0),
          debitAccount('Pagar a', widget.liability?.idDebit),
          const SizedBox(height: 10.0),
          const Divider(),
          const SizedBox(height: 10.0),
          RichText(
              text: const TextSpan(children: [
            TextSpan(
                text: 'Transacción realizada el día ',
                style: TextStyle(color: colorTextoSecundario, fontSize: 12.0))
          ])),
          const SizedBox(height: 5.0),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: widget.liability?.dtLiability,
                style: const TextStyle(
                    color: colorTextoTitulo,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0))
          ])),
          const SizedBox(height: 10.0),
          RichText(
              text: const TextSpan(children: [
            TextSpan(
                text: 'Numéro de referencia:',
                style: TextStyle(color: colorTextoSecundario, fontSize: 12.0)),
          ])),
          const SizedBox(height: 5.0),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'DDA # ${widget.liability?.idLibiality.toString()}',
                style: const TextStyle(
                    color: colorTextoTitulo,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0))
          ])),
          const SizedBox(height: 10.0),
          RichText(
              text: TextSpan(children: [
            /*TextSpan(
                              text: 'Cuotas',
                              style: TextStyle(
                                  color: colorTextoSecundario, fontSize: 12.0)),*/
            TextSpan(
                text: widget.liability?.observations,
                style: const TextStyle(
                    color: colorTextoTitulo,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0))
          ])),
          const SizedBox(height: 20.0),
          SizedBox(
              height: 40.0,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  padding: const EdgeInsets.all(0.0),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      transform: GradientRotation(-80),
                      colors: [
                        colorSecundario,
                        colorPrimario,
                      ],
                      begin: FractionalOffset(.18, .9),
                      end: FractionalOffset(.4, -0.2),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: () {
                      // Tu código para manejar la acción al hacer clic
                    },
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 300.0,
                        minWidth: 50.0,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Pagar',
                        style: TextStyle(
                          color: colorTextoBlanco,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = 'voucher_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);
    return result['filepath'];
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getTemporaryDirectory();
    final image = File('${directory.path}/voucher.png');
    image.writeAsBytesSync(bytes);
    const tag = 'Shared from PaymentsApp';
    await Share.shareFiles([image.path], text: tag);
  }

  Future<Directory> getTemporaryDirectory() async {
    final String path = Directory.systemTemp.path;
    return Directory(path);
  }
}

class MissingPlatformDirectoryException implements Exception {
  final String message;

  MissingPlatformDirectoryException(this.message);

  @override
  String toString() => 'MissingPlatformDirectoryException: $message';
}
