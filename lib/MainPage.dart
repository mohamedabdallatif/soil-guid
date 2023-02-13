import 'dart:async';

import 'package:flutter/material.dart';
import 'package:humidity_detector/chart.dart';
import 'package:humidity_detector/table.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import './BackgroundCollectingTask.dart';
import './SelectBondedDevicePage.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {


  //Timer? _discoverableTimeoutTimer;

  BackgroundCollectingTask? _collectingTask;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Humidity detector'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 250),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: ElevatedButton(
                child: ((_collectingTask?.inProgress ?? false)
                    ? const Text('Disconnect and stop background collecting')
                    : const Text('Connect to start background collecting')),
                onPressed: () async {
                  if (_collectingTask?.inProgress ?? false) {
                    await _collectingTask!.cancel();
                    setState(() {
                      /* Update for `_collectingTask.inProgress` */
                    });
                  } else {
                    final BluetoothDevice? selectedDevice =
                        await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const SelectBondedDevicePage(
                              checkAvailability: false);
                        },
                      ),
                    );

                    if (selectedDevice != null) {
                      await _startBackgroundTask(context, selectedDevice);
                      setState(() {
                        /* Update for `_collectingTask.inProgress` */
                      });
                    }
                  }
                },
              ),
            ),
            
            ListTile(
              title: ElevatedButton(
                onPressed: (_collectingTask != null)
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ScopedModel<BackgroundCollectingTask>(
                                model: _collectingTask!,
                                child: const ChartPage(),
                              );
                            },
                          ),
                        );
                      }
                    : null,
                child: const Text('View Chart'),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: (_collectingTask != null)
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ScopedModel<BackgroundCollectingTask>(
                                model: _collectingTask!,
                                child:  const TablePage(),
                              );
                            },
                          ),
                        );
                      }
                    : null,
                child: const Text('View Table'),
              ),
            ),
            
    ],
    ),
      ),
    );
  }

  Future<void> _startBackgroundTask(
    BuildContext context,
    BluetoothDevice server,
  ) async {
    try {
      _collectingTask = await BackgroundCollectingTask.connect(server);
      await _collectingTask!.start();
    } catch (ex) {
      _collectingTask?.cancel();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error occured while connecting'),
            content: Text(ex.toString()),
            actions: <Widget>[
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
