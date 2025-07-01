import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gold_stream_app/src/gold/data/fake_gold_api.dart';
import 'package:gold_stream_app/src/gold/presentation/widgets/gold_header.dart';
import 'package:intl/intl.dart';

class GoldScreen extends StatefulWidget {
  const GoldScreen({super.key});

  @override
  State<GoldScreen> createState() => _GoldScreenState();
}

class _GoldScreenState extends State<GoldScreen> {
  // State
  /// Platzhalter für den Goldpreis
  /// soll durch den Stream `getGoldPriceStream()` ersetzt werden
  double goldPrice = 69.22;

  StreamSubscription<double>? _goldPriceSubscription;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoldHeader(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Live Kurs:',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  FilledButton(
                    onPressed: () {
                      Stream<double> _goldPriceStream = getGoldPriceStream();
                      _goldPriceSubscription = _goldPriceStream.listen((price) {
                        setState(() {
                          goldPrice = price;
                        });
                      });
                    },
                    child: Text('Lade den Live Kurs'),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    NumberFormat.simpleCurrency(
                      locale: 'de_DE',
                    ).format(goldPrice),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      setState(() {
                        _goldPriceSubscription?.cancel();
                      });
                    },
                    child: Text('Stop den Live Kurs'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
