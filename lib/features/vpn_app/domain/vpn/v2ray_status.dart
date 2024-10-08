import 'package:Helios/features/vpn_app/domain/vpn/enums/enums.dart';
import 'package:Helios/features/vpn_app/domain/vpn/models/vpn_status.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class V2RayStatus extends StatefulWidget {
  const V2RayStatus({super.key, required this.child});

  final Widget child;

  static VPNStatus? of(BuildContext context, {bool listen = false}) =>
      _V2RayStatusInheritedWidget.of(context, listen: listen).status;

  static void update(BuildContext context, {required VPNStatus newStatus}) =>
      _V2RayStatusInheritedWidget.of(context)
          .state
          ._update(newStatus: newStatus);

  @override
  State<V2RayStatus> createState() => _V2RayStatus();
}

class _V2RayStatus extends State<V2RayStatus> {
  VPNStatus? status;
  final Box hiveBox = Hive.box<VPNStatus>("VPNStatus");

  @override
  void initState() {
    super.initState();

    status = hiveBox.get("vpnStatus");

    if (status != null) {
      setState(() {
        status!.status = Status.restoring;
      });
    }
  }

  void _update({required VPNStatus newStatus}) {
    setState(() {
      
    });

    if (hiveBox.isOpen) {
      hiveBox.put
    }
  }

  @override
  Widget build(BuildContext context) => _V2RayStatusInheritedWidget(
        state: this,
        status: status,
        child: widget.child,
      );
}

class _V2RayStatusInheritedWidget extends InheritedWidget {
  const _V2RayStatusInheritedWidget({
    required this.state,
    required this.status,
    required super.child,
  });

  final _V2RayStatus state;
  final VPNStatus? status;

  static _V2RayStatusInheritedWidget? maybeof(BuildContext context,
          {bool listen = false}) =>
      listen
          ? context
              .dependOnInheritedWidgetOfExactType<_V2RayStatusInheritedWidget>()
          : context
              .getInheritedWidgetOfExactType<_V2RayStatusInheritedWidget>();

  static _V2RayStatusInheritedWidget of(BuildContext context,
          {bool listen = false}) =>
      maybeof(context, listen: listen)!;

  @override
  bool updateShouldNotify(_V2RayStatusInheritedWidget oldWidget) =>
      status != oldWidget.status;
}
