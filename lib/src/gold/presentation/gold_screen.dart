import 'package:flutter/material.dart';
import 'package:gold_stream_app/src/gold/data/fake_gold_api.dart';
import 'package:gold_stream_app/src/gold/presentation/widgets/gold_header.dart';
import 'package:intl/intl.dart';

class GoldScreen extends StatelessWidget {
  const GoldScreen({super.key});
  @override
  Widget build(BuildContext context) {
    /// Platzhalter für den Goldpreis
    /// soll durch den Stream `getGoldPriceStream()` ersetzt werden
    //double goldPrice = 69.22; test

    Stream<double> goldPriceStream = getGoldPriceStream();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoldHeader(),
              SizedBox(height: 20),
              Text(
                'Live Kurs:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              // ERLEDIGT: Verwende einen StreamBuilder, um den Goldpreis live anzuzeigen
              // statt des konstanten Platzhalters
              StreamBuilder(
                stream: goldPriceStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Fehler: ${snapshot.error}');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return Text(
                      NumberFormat.simpleCurrency(
                        locale: 'de_DE',
                      ).format(snapshot.data),
                      style: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    );
                  } else {
                    return Text('No data available!');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
