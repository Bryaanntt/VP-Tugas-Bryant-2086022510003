import 'package:flutter/material.dart';

const int kError = 3;
const bool kFixed = false;

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: SafeArea(child: ErrorDemo())),
  ),
);

const String kLong =
    'Teks ini merupakan teks terpanjang sedunia yang hanya boleh dibaca oleh orang tecepat di dunia. '
    'Teks ini merupakan teks terpanjang sedunia yang hanya boleh dibaca oleh orang tecepat di dunia. '
    'Teks ini merupakan teks terpanjang sedunia yang hanya boleh dibaca oleh orang tecepat di dunia. '
    'Teks ini merupakan teks terpanjang sedunia yang hanya boleh dibaca oleh orang tecepat di dunia. '
    'Teks ini merupakan teks terpanjang sedunia yang hanya boleh dibaca oleh orang tecepat di dunia. '
    'Teks ini merupakan teks terpanjang sedunia yang hanya boleh dibaca oleh orang tecepat di dunia. ';

class ErrorDemo extends StatelessWidget {
  const ErrorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    switch (kError) {
      case 1:
        // ERROR 1: Row overflow horizontal
        return kFixed
            ? const Row(
                children: [
                  Expanded(
                    child: Text(
                      kLong,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.star),
                ],
              )
            : const Row(children: [Text(kLong), Icon(Icons.star)]);

      case 2:
        // ERROR 2: ListView di dalam Column (unbounded height)
        final items = [for (var i = 0; i < 20; i++) Text('Item $i')];
        return kFixed
            ? Column(
                children: [
                  const Text('Judul'),
                  Expanded(child: ListView(children: items)),
                ],
              )
            : Column(
                children: [
                  const Text('Judul'),
                  ListView(children: items),
                ],
              );

      default:
        // ERROR 3: Column overflow vertikal
        final boxes = [
          for (var i = 0; i < 30; i++)
            Container(
              height: 50,
              color: Colors.blue.withValues(alpha: 0.3 + (i % 3) * 0.2),
            ),
        ];
        return kFixed
            ? SingleChildScrollView(child: Column(children: boxes))
            : Column(children: boxes);
    }
  }
}
