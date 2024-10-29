import 'package:flutter/material.dart';
import 'package:paymentsapp/src/constants/constants.dart';
import 'package:paymentsapp/src/widgets/circulos_widget.dart';

class MovementDetail extends StatelessWidget {
  const MovementDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 100.0, bottom: 200.0, left: 20.0, right: 20.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 8.0,
        child: Stack(
          children: <Widget>[
            _fondoCard(),
            Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.only(top: 60.0, left: 10.0, right: 10.0),
              child: Column(
                children: <Widget>[
                  //iconSend(),
                  const SizedBox(height: 20.0),
                  RichText(
                      text: const TextSpan(children: [
                    /*TextSpan(
                        text: 'Envio exitoso a ',
                        style: TextStyle(
                            color: colorTextoSecundario, fontSize: 12.0)),*/
                    TextSpan(
                        text: 'COMPROBANTE DE PAGO',
                        style: TextStyle(
                            color: colorTextoTitulo,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0))
                  ])),
                  const SizedBox(height: 10.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Pago realizado',
                        style: TextStyle(color: colorPrimario, fontSize: 14.0))
                  ])),
                  const SizedBox(height: 15.0),
                  const Divider(),
                  const SizedBox(height: 10.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Transacción realizada el día ',
                        style: TextStyle(
                            color: colorTextoSecundario, fontSize: 14.0))
                  ])),
                  const SizedBox(height: 5.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: '30-08-2023 15:00:00',
                        style: TextStyle(
                            color: colorTextoTitulo,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0))
                  ])),
                  const SizedBox(height: 10.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Numéro de referencia: ',
                        style: TextStyle(
                            color: colorTextoSecundario, fontSize: 14.0)),
                  ])),
                  const SizedBox(height: 5.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'PG-001',
                        style: TextStyle(
                            color: colorTextoTitulo,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0))
                  ])),
                  const SizedBox(height: 10.0),
                  const Divider(),
                  const Divider(),
                  const SizedBox(height: 5.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'DETALLE',
                        style: TextStyle(
                            color: colorTextoTitulo,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0))
                  ])),
                  const SizedBox(height: 5.0),
                  const Divider(),
                  const Divider(),
                  const SizedBox(height: 20.0),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Parqueadero',
                        style: TextStyle(
                            color: colorTextoTitulo,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0)),
                    TextSpan(
                        text: '\$ 30.000',
                        style: TextStyle(
                            color: colorTextoTitulo,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0))
                  ])),
                  const Text('Cuota # 1',
                      style: TextStyle(
                        color: colorTextoTitulo,
                        fontSize: 14.0,
                      )),
                  const SizedBox(height: 50.0),
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
                                'Enviar',
                                style: TextStyle(
                                  color: colorTextoBlanco,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              /*child: ElevatedButton(
                                onPressed: () {
                                  //_shareAsImage(
                                  //  '¡Hola desde mi aplicación Flutter!');
                                },
                                child: Text('Compartir como Imagen'),                                
                              ),*/
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _fondoCard() {
    return SizedBox(
      width: 350.0,
      height: 455.0,
      child: Stack(
        children: <Widget>[
          Positioned(left: -80.0, top: -80.0, child: circulo1()),
          Positioned(right: -90.0, bottom: -90.0, child: circulo1())
        ],
      ),
    );
  }

  /*Future<void> _shareAsImage(String text) async {
    // Generar la imagen a partir del texto
    Uint8List bytes = await _generateImage(text);

    // Guardar la imagen en un archivo temporal
    File imageFile = await _saveImageToTempFile(bytes);

    // Compartir la imagen
    if (imageFile != null) {
      Share.shareFiles([imageFile.path],
          text: '¡Mira esta imagen generada desde mi aplicación Flutter!');
    }
  }

  Future<Uint8List> _generateImage(String text) async {
    // Crear una nueva imagen
    img.Image image = img.Image(width: 200, height: 100);

    // Rellenar la imagen con un color de fondo
    img.fill(image, color: img.getColor(255, 255, 255));

    // Configurar el estilo del texto
    img.Image fontImage = img.Image(width: 200, height: 100);
    img.fill(fontImage, color: img.getColor(0x00, 0x00, 0x00));
    img.drawString(fontImage, img.arial_24, 10, 40, text);

    // Superponer la imagen del texto en la imagen de fondo
    img.drawImage(image, fontImage, dstX: 0, dstY: 0);

    // Convertir la imagen a bytes
    Uint8List bytes = Uint8List.fromList(img.encodePng(image));

    return bytes;
  }

  Future<File> _saveImageToTempFile(Uint8List bytes) async {
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/image.png');

    await tempFile.writeAsBytes(bytes);

    return tempFile;
  }*/
}
