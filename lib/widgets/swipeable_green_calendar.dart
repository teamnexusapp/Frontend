import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SwipeableGreenCalendar extends StatefulWidget {
  const SwipeableGreenCalendar({
    super.key,
    required this.initialMonth,
    required this.selectedDates,
    this.onDateToggle,
  });

  final DateTime initialMonth;
  final Set<DateTime> selectedDates;
  final ValueChanged<DateTime>? onDateToggle;

  @override
  State<SwipeableGreenCalendar> createState() => _SwipeableGreenCalendarState();
}

class _SwipeableGreenCalendarState extends State<SwipeableGreenCalendar> {
  static const int _initialPage = 1200;
  static const Color _accent = Color(0xFFA8D497);
  late final PageController _pageController;
  late DateTime _baseMonth;
  late DateTime _visibleMonth;
  late Set<DateTime> _localSelection;

  @override
  void initState() {
    super.initState();
    _baseMonth = _monthOnly(widget.initialMonth);
    _visibleMonth = _baseMonth;
    _pageController = PageController(initialPage: _initialPage);
    _localSelection = widget.selectedDates.map(_dayOnly).toSet();
  }

  @override
  void didUpdateWidget(covariant SwipeableGreenCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    final updated = widget.selectedDates.map(_dayOnly).toSet();
    if (!setEquals(updated, _localSelection)) {
      _localSelection = updated;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final monthLabel = DateFormat('MMMM yyyy').format(_visibleMonth);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _jumpBy(-1),
                icon: const Icon(Icons.chevron_left, color: Colors.white, size: 26),
                splashRadius: 20,
              ),
              Text(
                monthLabel,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
              IconButton(
                onPressed: () => _jumpBy(1),
                icon: const Icon(Icons.chevron_right, color: Colors.white, size: 26),
                splashRadius: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        _buildDayLabels(),
        const SizedBox(height: 6),
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) => setState(() => _visibleMonth = _monthForPage(page)),
            itemBuilder: (context, pageIndex) {
              final month = _monthForPage(pageIndex);
              return _MonthGrid(
                month: month,
                selectedDates: _localSelection,
                onToggle: _handleDateToggle,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDayLabels() {
    const dayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 2),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 0,
        ),
        itemCount: 7,
        itemBuilder: (context, index) => Center(
          child: Text(
            dayLabels[index],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }

  void _jumpBy(int delta) {
    final currentPage = _pageController.page?.round() ?? _initialPage;
    final target = currentPage + delta;
    _pageController.animateToPage(
      target,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
    );
  }

  void _handleDateToggle(DateTime date) {
    final normalized = _dayOnly(date);
    setState(() {
      if (_localSelection.any((d) => _isSameDay(d, normalized))) {
        _localSelection = _localSelection.where((d) => !_isSameDay(d, normalized)).toSet();
      } else {
        _localSelection = {..._localSelection, normalized};
      }
    });
    widget.onDateToggle?.call(normalized);
  }

  DateTime _monthForPage(int pageIndex) {
    final offset = pageIndex - _initialPage;
    return DateTime(_baseMonth.year, _baseMonth.month + offset, 1);
  }

  DateTime _monthOnly(DateTime date) => DateTime(date.year, date.month, 1);
  DateTime _dayOnly(DateTime date) => DateTime(date.year, date.month, date.day);

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.selectedDates,
    required this.onToggle,
  });

  final DateTime month;
  final Set<DateTime> selectedDates;
  final ValueChanged<DateTime> onToggle;

  static const Color _accent = Color(0xFFA8D497);

  @override
  Widget build(BuildContext context) {
    final firstWeekday = month.weekday % 7; // 0=Sunday ... 6=Saturday
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final prevMonth = DateTime(month.year, month.month - 1, 1);
    final nextMonth = DateTime(month.year, month.month + 1, 1);
    final daysInPrevMonth = DateUtils.getDaysInMonth(prevMonth.year, prevMonth.month);

    final totalCells = (firstWeekday + daysInMonth) <= 35 ? 35 : 42;

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: totalCells,
        itemBuilder: (context, index) {
          final dayInfo = _resolveDay(
            index: index,
            firstWeekday: firstWeekday,
            daysInMonth: daysInMonth,
            daysInPrevMonth: daysInPrevMonth,
            prevMonth: prevMonth,
            nextMonth: nextMonth,
          );

          final isSelected = selectedDates.any((d) => _isSameDay(d, dayInfo.date));
          final textColor = dayInfo.isOutside
              ? _accent.withOpacity(0.4)
              : isSelected
                  ? const Color(0xFF2E683D)
                  : Colors.white;

          return Center(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: dayInfo.isOutside ? null : () => onToggle(dayInfo.date),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? _accent : Colors.transparent,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${dayInfo.date.day}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: textColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _DayDetail _resolveDay({
    required int index,
    required int firstWeekday,
    required int daysInMonth,
    required int daysInPrevMonth,
    required DateTime prevMonth,
    required DateTime nextMonth,
  }) {
    if (index < firstWeekday) {
      final day = daysInPrevMonth - firstWeekday + index + 1;
      return _DayDetail(date: DateTime(prevMonth.year, prevMonth.month, day), isOutside: true);
    }

    if (index < firstWeekday + daysInMonth) {
      final day = index - firstWeekday + 1;
      return _DayDetail(date: DateTime(month.year, month.month, day), isOutside: false);
    }

    final day = index - (firstWeekday + daysInMonth) + 1;
    return _DayDetail(date: DateTime(nextMonth.year, nextMonth.month, day), isOutside: true);
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _DayDetail {
  _DayDetail({required this.date, required this.isOutside});

  final DateTime date;
  final bool isOutside;
}
