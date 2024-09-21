import 'package:flutter/material.dart';

class LoadingIcon {
  final _loadingIcon = OverlayEntry(
    builder: (context) => Center(
      child: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.onBackground,
        ),
        child: const CircularProgressIndicator.adaptive(),
      ),
    ),
  );

  final modalBarrier = OverlayEntry(
    builder: (context) => const ModalBarrier(
      dismissible: false,
      color: Colors.black54,
    ),
  );

  void showLoadingIcon(BuildContext context) {
    Overlay.of(context).insert(modalBarrier);
    Overlay.of(context).insert(_loadingIcon);
  }

  /// PLEASE NOTICE:
  /// AFTER CALLING THIS METHOD FOR A LoadingIcon CLASS INSTANCE,
  /// THAT INSTANCE IS NOT USABLE ANYMORE.
  void removeLoadingIcon() {
    //сделайте лучше, если не нравится)
    _loadingIcon.remove();
    modalBarrier.remove();
    _loadingIcon.dispose();
    modalBarrier.dispose();
  }
}