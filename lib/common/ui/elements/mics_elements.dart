import 'package:flutter/material.dart';

SnackBar snackBar(
  BuildContext context, {
  required String title,
  Duration duration = const Duration(seconds: 10),
}) =>
    SnackBar(
      content: Row(
        children: <Widget>[
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: "Понятно",
        onPressed: () {},
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      duration: const Duration(seconds: 10),
    );

class LoadingIcon {
  final loadingIcon = OverlayEntry(
    builder: (context) => Center(
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.onBackground,
        ),
        padding: const EdgeInsets.all(8),
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
    Overlay.of(context).insert(loadingIcon);
  }

  void removeLoadingIcon() {
    loadingIcon.remove();
    modalBarrier.remove();
    loadingIcon.dispose();
    modalBarrier.dispose();
  }
}
