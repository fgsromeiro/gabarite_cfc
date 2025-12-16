import '../../shared/export/app_export.dart';

class AppTable extends StatefulWidget {
  const AppTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.width,
  });

  final List<DataColumn> columns;
  final List<DataRow> rows;
  final double width;

  @override
  State<AppTable> createState() => _AppTableState();
}

class _AppTableState extends State<AppTable> {
  late final ScrollController _scrollControllerHorizontal;
  late final ScrollController _scrollControllerHorizontal2;
  late final ScrollController _scrollControllerVertical;
  bool _isSyncing = false;

  @override
  void initState() {
    _scrollControllerHorizontal = ScrollController();
    _scrollControllerHorizontal2 = ScrollController();
    _scrollControllerVertical = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollControllerHorizontal.dispose();
    _scrollControllerHorizontal2.dispose();
    _scrollControllerVertical.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Scrollbar(
            controller: _scrollControllerVertical,
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollControllerVertical,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (!_isSyncing &&
                      notification is ScrollUpdateNotification &&
                      notification.metrics.axis == Axis.horizontal) {
                    _isSyncing = true;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollControllerHorizontal2.hasClients) {
                        _scrollControllerHorizontal2.jumpTo(notification.metrics.pixels);
                      }
                      _isSyncing = false;
                    });
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollControllerHorizontal,
                  child: RepaintBoundary(
                    child: DataTable(
                      dataRowMaxHeight: context.sz.height * 0.1,
                      columns: widget.columns,
                      rows: widget.rows,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: context.colorScheme.surface),
          child: Scrollbar(
            controller: _scrollControllerHorizontal2,
            trackVisibility: true,
            thumbVisibility: true,
            scrollbarOrientation: ScrollbarOrientation.top,
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (!_isSyncing &&
                    notification is ScrollUpdateNotification &&
                    notification.metrics.axis == Axis.horizontal) {
                  _isSyncing = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollControllerHorizontal.hasClients) {
                      _scrollControllerHorizontal.jumpTo(notification.metrics.pixels);
                    }
                    _isSyncing = false;
                  });
                }
                return false;
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollControllerHorizontal2,
                child: RepaintBoundary(
                  child: DataTable(
                    dataRowMaxHeight: context.sz.height * 0.1,
                    columns: widget.columns,
                    rows: [],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
