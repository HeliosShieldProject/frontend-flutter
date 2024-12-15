import 'package:Helios/common/constants/literals.dart';
import 'package:Helios/common/constants/multipliers.dart';
import 'package:Helios/common/constants/numeric_constants.dart';
import 'package:Helios/common/enums/enums.dart';
import 'package:Helios/common/ui/utils/blank_spacer.dart';
import 'package:Helios/features/register_sign_in/widgets/snackbar.dart';
import 'package:Helios/features/settings/domain/bloc/history_bloc/bloc.dart';
import 'package:Helios/features/vpn_app/widgets/helios_vpn_card.dart';
import 'package:Helios/repositories/local_repository/vpn_connection/models/ip.dart';
import 'package:Helios/repositories/session_repository/entities/get_history_server_entity.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late ColorScheme colorScheme;
  late TextTheme textTheme;

  late final ScrollController _scrollController;

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9999);
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    colorScheme = theme.colorScheme;
    textTheme = theme.textTheme;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _onTapAppBar(BuildContext context) => Navigator.maybePop(context);

  void _scrollListener() {
    if (_isBottom) context.read<HistoryBloc>().add(BottomHitEvent());
  }

  void _historyBlocListener(BuildContext context, HistoryState state) {
    switch (state.status) {
      case Auth.loading:
        break;
      case Auth.success:
        break;
      default:
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar(context, title: state.status!.name),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<HistoryBloc, HistoryState>(
        listener: _historyBlocListener,
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: NumericConstants.iconSize,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () => _onTapAppBar(context),
            ),
            title: Text(
              Literals.history,
              style: textTheme.titleLarge,
            ),
          ),
          body: Column(
            spacing: NumericConstants.spacerSize,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: NumericConstants.horizontalPadding),
                child: HistoryPageCard(values: state.lastWeek),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(NumericConstants.borderRadius),
                      topRight: Radius.circular(NumericConstants.borderRadius),
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: NumericConstants.horizontalPadding,
                  ),
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(
                      NumericConstants.horizontalPadding,
                    ),
                    itemCount: state.historyInfo.length,
                    itemBuilder: (context, index) {
                      final HistoryInfo info = state.historyInfo[index];

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    height: NumericConstants.listElementHeight,
                                    width: NumericConstants.listElementHeight,
                                    alignment: Alignment.center,
                                    child: CountryFlag.fromCountryCode(
                                      info.country.countryCode,
                                      shape: const Circle(),
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                  const BlankSpacer(horizontal: true),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        info.country.countryName,
                                        style: textTheme.titleMedium!.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        const IP.unknown().toString(),
                                        style: textTheme.labelMedium!.copyWith(
                                          color: Colors.white
                                              .withValues(alpha: 0.5),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "${info.duration.inHours}:${info.duration.inMinutes.remainder(60)}:${info.duration.inSeconds.remainder(60)}",
                                    style: textTheme.labelMedium!.copyWith(
                                        color: Colors.white
                                            .withValues(alpha: 0.5)),
                                  ),
                                  Text(
                                    "${info.dateTimeOpened.day}.${info.dateTimeOpened.month}.${info.dateTimeOpened.year}",
                                    style: textTheme.labelMedium!.copyWith(
                                        color: Colors.white
                                            .withValues(alpha: 0.5)),
                                  ),
                                ],
                              )
                            ],
                          ),
                          if (index != state.historyInfo.length - 1) ...[
                            const BlankSpacer(),
                            Divider(
                              color: colorScheme.onTertiary,
                              thickness: 2,
                              height: 0,
                            ),
                            const BlankSpacer(),
                          ]
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      );
}

class HistoryPageCard extends StatefulWidget {
  const HistoryPageCard({
    super.key,
    required this.values,
  }) : assert(values.length <= 7,
            "Values list can't be longer than 7 => ${values.length}");

  final List<double> values;

  @override
  State<HistoryPageCard> createState() => _HistoryPageCardState();
}

class _HistoryPageCardState extends State<HistoryPageCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Gradient> _gradientAnimation;

  final GradientTween _gradientTween = GradientTween.vertical();

  late double maxValue = _maxValue(list: widget.values);

  late ColorScheme colorScheme;
  late TextTheme textTheme;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _gradientAnimation = _gradientTween.animate(_animationController);

    if (widget.values.isEmpty) {
      _animationController.repeat();
    }
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    colorScheme = theme.colorScheme;
    textTheme = theme.textTheme;

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(HistoryPageCard oldWidget) {
    if (oldWidget.values.isEmpty && widget.values.isNotEmpty) {
      _animationController.stop();
    } else if (oldWidget.values.isNotEmpty && widget.values.isEmpty) {
      _animationController.repeat();
    }

    if (oldWidget.values != widget.values) {
      maxValue = _maxValue(list: widget.values);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  double _maxValue({required List<double> list}) {
    double max = 0;

    for (int i = 0; i < list.length; i++) {
      if (list[i] > max) {
        max = list[i];
      }
    }

    return max;
  }

  List<Widget> _getGraphChildren() {
    final List<Widget> result = <Widget>[];

    if (widget.values.isEmpty) {
      for (int i = 0; i < 7; i++) {
        result.add(
          AnimatedBuilder(
            animation: _gradientAnimation,
            builder: (context, child) => Container(
              height: 130,
              width: 20,
              decoration: BoxDecoration(
                gradient: _gradientAnimation.value,
                borderRadius:
                    BorderRadius.circular(NumericConstants.borderRadius),
              ),
            ),
          ),
        );
      }
    } else {
      for (int i = 0; i < 7; i++) {
        result.add(
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(
              height: 130,
              width: 20,
            ),
            child: CustomPaint(
              painter: GraphPainter(
                value: (widget.values.elementAtOrNull(i) ?? 0) /
                    (maxValue != 0 ? maxValue : 1),
                borderRadius: NumericConstants.borderRadius,
                bgColor: colorScheme.onTertiary,
                fgColor: Colors.white,
              ),
            ),
          ),
        );
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: colorScheme.tertiary,
          borderRadius: BorderRadius.circular(NumericConstants.borderRadius),
        ),
        padding: const EdgeInsets.all(NumericConstants.horizontalPadding),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.public_rounded,
                  color: Colors.white,
                  size: NumericConstants.iconSize,
                ),
                const BlankSpacer(horizontal: true),
                Text(
                  "Длительность сессий за 7 дней",
                  style: textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
              ],
            ),
            const BlankSpacer(
              multiplier: Multipliers.heliosListTileDivider2BlankSpacer,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _getGraphChildren(),
            )
          ],
        ),
      );
}

class GraphPainter extends CustomPainter {
  GraphPainter({
    required this.value,
    required this.borderRadius,
    required this.bgColor,
    required this.fgColor,
  }) : assert(value <= 1, "Value can't be higher that 1 => $value");

  final double value;
  final double borderRadius;
  final Color bgColor;
  final Color fgColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double divisionHeight = size.height * (1 - value);
    final Rect rect = Offset.zero & size;

    final Path bgPath = Path()
      ..lineTo(0.0, divisionHeight)
      ..lineTo(size.width, divisionHeight)
      ..lineTo(size.width, 0.0)
      ..lineTo(0.0, 0.0);

    final Paint bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

    final Path fgPath = Path()
      ..moveTo(0.0, divisionHeight)
      ..lineTo(size.width, divisionHeight)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..lineTo(0.0, divisionHeight);

    final Paint fgPaint = Paint()
      ..color = fgColor
      ..style = PaintingStyle.fill;

    canvas
      ..clipRRect(
        RRect.fromRectXY(rect, borderRadius, borderRadius),
      )
      ..drawPath(bgPath, bgPaint)
      ..drawPath(fgPath, fgPaint);
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) =>
      (oldDelegate.value != value);
}
