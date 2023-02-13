import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends ListTile {
  BluetoothDeviceListEntry({super.key, 
    required BluetoothDevice device,
    GestureTapCallback? onTap,
    bool enabled = true,
  }) : super(
          onTap: onTap,
          enabled: enabled,
          leading:
              const Icon(Icons.devices),
          title: Text(device.name ?? ""),
          subtitle: Text(device.address.toString()),
        );
}
