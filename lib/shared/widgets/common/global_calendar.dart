import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

// ─────────────────────────────────────────────
//  Data model
// ─────────────────────────────────────────────
enum _CalendarView { day, month, year }

// ─────────────────────────────────────────────
//  Public widget
// ─────────────────────────────────────────────
class GlobalCalendar extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateSelected;

  /// Days that should show an "event" dot in the grid. Time portion is
  /// ignored; only the date is compared.
  final Set<DateTime>? eventDates;

  const GlobalCalendar({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.eventDates,
  });

  @override
  State<GlobalCalendar> createState() => _GlobalCalendarState();
}

class _GlobalCalendarState extends State<GlobalCalendar>
    with TickerProviderStateMixin {
  // ── state ──────────────────────────────────
  late DateTime _selected;
  late DateTime _displayed; // month/year being browsed
  _CalendarView _view = _CalendarView.day;

  /// Event dates normalized to date-only (year/month/day) for cheap lookup.
  late Set<DateTime> _eventDateSet;

  void _rebuildEventDateSet() {
    _eventDateSet = (widget.eventDates ?? const <DateTime>{})
        .map(DateUtils.dateOnly)
        .toSet();
  }

  // ── animations ─────────────────────────────
  late AnimationController _panelCtrl;
  late Animation<double> _panelFade;
  late Animation<Offset> _panelSlide;

  late AnimationController _calCtrl;
  late Animation<double> _calFade;
  late Animation<Offset> _calSlide;

  // direction for calendar swipe (-1 prev, 1 next)
  int _slideDir = 1;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate ?? DateTime.now();
    _displayed = DateTime(_selected.year, _selected.month);
    _rebuildEventDateSet();

    _panelCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _panelFade = CurvedAnimation(parent: _panelCtrl, curve: Curves.easeOut);
    _panelSlide = Tween<Offset>(
      begin: const Offset(0, -0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _panelCtrl, curve: Curves.easeOut));

    _calCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _calFade = CurvedAnimation(parent: _calCtrl, curve: Curves.easeOut);
    _calSlide = Tween<Offset>(
      begin: const Offset(0.15, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _calCtrl, curve: Curves.easeOut));

    _panelCtrl.forward();
    _calCtrl.forward();
  }

  @override
  void didUpdateWidget(covariant GlobalCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.eventDates != widget.eventDates) {
      _rebuildEventDateSet();
    }
  }

  @override
  void dispose() {
    _panelCtrl.dispose();
    _calCtrl.dispose();
    super.dispose();
  }

  // ── helpers ────────────────────────────────
  void _switchView(_CalendarView next) {
    if (_view == next) {
      _animatePanel(() => _view = _CalendarView.day);
      return;
    }
    _animatePanel(() => _view = next);
  }

  void _animatePanel(VoidCallback change) {
    _panelCtrl.reverse().then((_) {
      setState(change);
      _panelCtrl.forward();
    });
  }

  void _animateCal(VoidCallback change) {
    _calSlide = Tween<Offset>(
      begin: Offset(_slideDir * 0.18, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _calCtrl, curve: Curves.easeOut));

    _calCtrl.reverse().then((_) {
      setState(change);
      _calCtrl.forward();
    });
  }

  void _prevMonth() {
    _slideDir = -1;
    _animateCal(() {
      _displayed = DateTime(_displayed.year, _displayed.month - 1);
    });
  }

  void _nextMonth() {
    _slideDir = 1;
    _animateCal(() {
      _displayed = DateTime(_displayed.year, _displayed.month + 1);
    });
  }

  void _selectDay(DateTime date) {
    _slideDir = date.isBefore(_displayed) ? -1 : 1;
    if (date.year != _displayed.year || date.month != _displayed.month) {
      _animateCal(() {
        _selected = date;
        _displayed = DateTime(date.year, date.month);
      });
    } else {
      setState(() {
        _selected = date;
      });
    }
    widget.onDateSelected?.call(_selected);
  }

  void _selectMonth(int month) {
    _animatePanel(() {
      final daysInNewMonth = DateUtils.getDaysInMonth(_displayed.year, month);
      final clampedDay = _selected.day.clamp(1, daysInNewMonth);
      _displayed = DateTime(_displayed.year, month);
      _selected = DateTime(_displayed.year, month, clampedDay);
      _view = _CalendarView.day;
    });
    widget.onDateSelected?.call(_selected);
  }

  void _selectYear(int year) {
    _animatePanel(() {
      final daysInNewMonth = DateUtils.getDaysInMonth(year, _displayed.month);
      final clampedDay = _selected.day.clamp(1, daysInNewMonth);
      _displayed = DateTime(year, _displayed.month);
      _selected = DateTime(year, _selected.month, clampedDay);
      _view = _CalendarView.month;
    });
  }

  // ── build ──────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF1F5F9),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderRow(),
          const SizedBox(height: 4),
          FadeTransition(
            opacity: _panelFade,
            child: SlideTransition(
              position: _panelSlide,
              child: _buildActivePanel(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivePanel() {
    switch (_view) {
      case _CalendarView.day:
        return _DayPanel(
          displayed: _displayed,
          selected: _selected,
          firstDate: widget.firstDate ?? DateTime(2000),
          lastDate: widget.lastDate ?? DateTime(2050),
          eventDates: _eventDateSet,
          onPrev: _prevMonth,
          onNext: _nextMonth,
          onDateTap: _selectDay,
          onYearTap: () => _switchView(_CalendarView.year),
          onMonthTap: () => _switchView(_CalendarView.month),
          calFade: _calFade,
          calSlide: _calSlide,
        );
      case _CalendarView.month:
        return _MonthPanel(
          displayed: _displayed,
          selected: _selected,
          firstDate: widget.firstDate ?? DateTime(2000),
          lastDate: widget.lastDate ?? DateTime(2050),
          onMonthTap: _selectMonth,
          onYearTap: () => _switchView(_CalendarView.year),
        );
      case _CalendarView.year:
        return _YearPanel(
          selected: _selected,
          onYearTap: _selectYear,
          firstYear: (widget.firstDate ?? DateTime(2000)).year,
          lastYear: (widget.lastDate ?? DateTime(2050)).year,
        );
    }
  }
}

// ─────────────────────────────────────────────
//  Header row (just a spacer — panels carry their own headers)
// ─────────────────────────────────────────────
class _HeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

// ─────────────────────────────────────────────
//  Section header with label + sub-label (clickable)
// ─────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String label;
  final String subLabel;
  final VoidCallback onTap;

  const _SectionHeader({
    required this.label,
    required this.subLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xffF1F5F9), width: 0.7),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.bodyLargeBold),
            const SizedBox(height: 2),
            Text(subLabel, style: AppTextStyles.captionRegular),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DAY PANEL
// ─────────────────────────────────────────────
class _DayPanel extends StatelessWidget {
  final DateTime displayed;
  final DateTime selected;
  final DateTime firstDate;
  final DateTime lastDate;
  final Set<DateTime> eventDates;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final ValueChanged<DateTime> onDateTap;
  final VoidCallback onYearTap;
  final VoidCallback onMonthTap;
  final Animation<double> calFade;
  final Animation<Offset> calSlide;

  // ignore: unused_field
  static const _weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
  static const _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  const _DayPanel({
    required this.displayed,
    required this.selected,
    required this.firstDate,
    required this.lastDate,
    required this.eventDates,
    required this.onPrev,
    required this.onNext,
    required this.onDateTap,
    required this.onYearTap,
    required this.onMonthTap,
    required this.calFade,
    required this.calSlide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          label: displayed.year.toString(),
          subLabel: 'Choose Year',
          onTap: onYearTap,
        ),
        const SizedBox(height: 4),
        _SectionHeader(
          label: _monthNames[displayed.month - 1],
          subLabel: 'Choose Month',
          onTap: onMonthTap,
        ),
        const SizedBox(height: 4),
        _DateSection(
          displayed: displayed,
          selected: selected,
          firstDate: firstDate,
          lastDate: lastDate,
          eventDates: eventDates,
          onPrev: onPrev,
          onNext: onNext,
          onDateTap: onDateTap,
          calFade: calFade,
          calSlide: calSlide,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Date section (header + grid)
// ─────────────────────────────────────────────
class _DateSection extends StatelessWidget {
  final DateTime displayed;
  final DateTime selected;
  final DateTime firstDate;
  final DateTime lastDate;
  final Set<DateTime> eventDates;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final ValueChanged<DateTime> onDateTap;
  final Animation<double> calFade;
  final Animation<Offset> calSlide;

  static const _weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  const _DateSection({
    required this.displayed,
    required this.selected,
    required this.firstDate,
    required this.lastDate,
    required this.eventDates,
    required this.onPrev,
    required this.onNext,
    required this.onDateTap,
    required this.calFade,
    required this.calSlide,
  });

  bool _hasEventOn(final DateTime date) =>
      eventDates.contains(DateUtils.dateOnly(date));

  List<_DayCell> _buildCells() {
    final firstDay = DateTime(displayed.year, displayed.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(
      displayed.year,
      displayed.month,
    );
    final startOffset = firstDay.weekday % 7; // Sunday = 0

    final prevMonth = DateTime(displayed.year, displayed.month - 1);
    final daysInPrev = DateUtils.getDaysInMonth(
      prevMonth.year,
      prevMonth.month,
    );

    final today = DateTime.now();
    final cells = <_DayCell>[];

    // prev month overflow
    for (int i = startOffset - 1; i >= 0; i--) {
      final d = daysInPrev - i;
      final date = DateTime(prevMonth.year, prevMonth.month, d);
      final isDisabled =
          date.isBefore(DateUtils.dateOnly(firstDate)) ||
          date.isAfter(DateUtils.dateOnly(lastDate));
      cells.add(
        _DayCell(
          date: date,
          isOverflow: true,
          isDisabled: isDisabled,
          isToday: DateUtils.isSameDay(date, today),
          hasEvent: _hasEventOn(date),
        ),
      );
    }

    // current month
    for (int d = 1; d <= daysInMonth; d++) {
      final date = DateTime(displayed.year, displayed.month, d);
      final isSelected = DateUtils.isSameDay(date, selected);
      final isDisabled =
          date.isBefore(DateUtils.dateOnly(firstDate)) ||
          date.isAfter(DateUtils.dateOnly(lastDate));

      cells.add(
        _DayCell(
          date: date,
          isSelected: isSelected,
          isDisabled: isDisabled,
          isToday: DateUtils.isSameDay(date, today),
          hasEvent: _hasEventOn(date),
        ),
      );
    }

    // next month overflow
    final nextMonth = DateTime(displayed.year, displayed.month + 1);
    final remaining = (7 - cells.length % 7) % 7;
    for (int d = 1; d <= remaining; d++) {
      final date = DateTime(nextMonth.year, nextMonth.month, d);
      final isDisabled =
          date.isBefore(DateUtils.dateOnly(firstDate)) ||
          date.isAfter(DateUtils.dateOnly(lastDate));
      cells.add(
        _DayCell(
          date: date,
          isOverflow: true,
          isDisabled: isDisabled,
          isToday: DateUtils.isSameDay(date, today),
          hasEvent: _hasEventOn(date),
        ),
      );
    }

    return cells;
  }

  @override
  Widget build(BuildContext context) {
    final cells = _buildCells();
    final rows = <List<_DayCell>>[];
    for (int i = 0; i < cells.length; i += 7) {
      rows.add(cells.sublist(i, i + 7));
    }

    final canPrev = displayed.isAfter(
      DateTime(firstDate.year, firstDate.month),
    );
    final canNext = displayed.isBefore(DateTime(lastDate.year, lastDate.month));

    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.text40, width: 0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date', style: AppTextStyles.bodyLargeBold),
                  const SizedBox(height: 2),
                  Text('Choose Date', style: AppTextStyles.captionRegular),
                ],
              ),
              const Spacer(),
              _NavButton(
                icon: Icons.chevron_left,
                onTap: canPrev ? onPrev : null,
              ),
              const SizedBox(width: 4),
              _NavButton(
                icon: Icons.chevron_right,
                onTap: canNext ? onNext : null,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Calendar body
          FadeTransition(
            opacity: calFade,
            child: SlideTransition(
              position: calSlide,
              child: Column(
                children: [
                  // Weekday headers
                  Row(
                    children: _weekdays
                        .map(
                          (w) => Expanded(
                            child: Center(
                              child: Text(
                                w,
                                style: AppTextStyles.bodySmallBold,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 4),
                  // Day rows
                  ...rows.map(
                    (row) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: row
                            .map(
                              (cell) => Expanded(
                                child: _DayCellWidget(
                                  cell: cell,
                                  onTap: cell.isDisabled
                                      ? null
                                      : () => onDateTap(cell.date),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Nav button
// ─────────────────────────────────────────────
class _NavButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _NavButton({required this.icon, required this.onTap});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.85,
      upperBound: 1.0,
      value: 1.0,
    );
    _scale = _ctrl;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTap() {
    if (widget.onTap == null) return;
    _ctrl.reverse().then((_) => _ctrl.forward());
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;
    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: enabled ? AppColors.white : AppColors.text20,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            widget.icon,
            size: 18,
            color: enabled ? AppColors.text500 : AppColors.text100,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Day cell data
// ─────────────────────────────────────────────
class _DayCell {
  final DateTime date;
  final bool isSelected;
  final bool isOverflow;
  final bool isDisabled;
  final bool isToday;
  final bool hasEvent;

  const _DayCell({
    required this.date,
    this.isSelected = false,
    this.isOverflow = false,
    this.isDisabled = false,
    this.isToday = false,
    this.hasEvent = false,
  });
}

// ─────────────────────────────────────────────
//  Day cell widget with tap animation
// ─────────────────────────────────────────────
class _DayCellWidget extends StatefulWidget {
  final _DayCell cell;
  final VoidCallback? onTap;

  const _DayCellWidget({required this.cell, this.onTap});

  @override
  State<_DayCellWidget> createState() => _DayCellWidgetState();
}

class _DayCellWidgetState extends State<_DayCellWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.8,
      upperBound: 1.0,
      value: widget.cell.isSelected ? 1.0 : 1.0,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onTap == null) return;
    _ctrl.reverse().then((_) => _ctrl.forward());
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final cell = widget.cell;
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _ctrl,
        child: SizedBox(
          height: 28,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                height: 24,
                decoration: BoxDecoration(
                  color: cell.isSelected
                      ? AppColors.primarymain
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    cell.isSelected ? 100 : 2,
                  ),
                  border: Border.all(
                    color: cell.isToday && !cell.isSelected
                        ? AppColors.primary300
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${cell.date.day}',
                  style: AppTextStyles.bodySmallRegular.copyWith(
                    fontWeight: cell.isSelected || cell.isToday
                        ? FontWeight.w700
                        : FontWeight.w400,
                    color: cell.isSelected
                        ? AppColors.white
                        : cell.isDisabled
                        ? AppColors.text100
                        : cell.isOverflow
                        ? AppColors.text40
                        : cell.isToday
                        ? AppColors.primarymain
                        : AppColors.text500,
                  ),
                ),
              ),
              // Event dot. Hidden when the day is selected (the filled pill
              // would swallow it) and dimmed for overflow / disabled days so
              // dots from other months feel less prominent.
              if (cell.hasEvent && !cell.isSelected)
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: cell.isDisabled || cell.isOverflow
                          ? AppColors.primary300
                          : AppColors.primarymain,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  MONTH PANEL
// ─────────────────────────────────────────────
class _MonthPanel extends StatelessWidget {
  final DateTime displayed;
  final DateTime selected;
  final DateTime firstDate;
  final DateTime lastDate;
  final ValueChanged<int> onMonthTap;
  final VoidCallback onYearTap;

  static const _months = [
    ['Jan', 'Feb', 'Mar', 'Apr'],
    ['May', 'Jun', 'Jul', 'Aug'],
    ['Sep', 'Oct', 'Nov', 'Dec'],
  ];

  const _MonthPanel({
    required this.displayed,
    required this.selected,
    required this.firstDate,
    required this.lastDate,
    required this.onMonthTap,
    required this.onYearTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          label: displayed.year.toString(),
          subLabel: 'Choose Year',
          onTap: onYearTap,
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.text40, width: 0.7),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Month', style: AppTextStyles.bodyLargeBold),
              const SizedBox(height: 2),
              Text('Choose Month', style: AppTextStyles.captionRegular),
              const SizedBox(height: 12),
              ..._months.asMap().entries.map(
                (rowEntry) => Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: rowEntry.value.asMap().entries.map((colEntry) {
                      final monthIndex = rowEntry.key * 4 + colEntry.key + 1;
                      final isSelected =
                          monthIndex == displayed.month &&
                          displayed.year == selected.year;

                      final monthDate = DateTime(displayed.year, monthIndex);
                      final isDisabled =
                          monthDate.isBefore(
                            DateTime(firstDate.year, firstDate.month),
                          ) ||
                          monthDate.isAfter(
                            DateTime(lastDate.year, lastDate.month),
                          );

                      return _MonthChip(
                        label: colEntry.value,
                        isSelected: isSelected,
                        isDisabled: isDisabled,
                        onTap: isDisabled
                            ? () {}
                            : () => onMonthTap(monthIndex),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        _SectionHeader(
          label: 'Date',
          subLabel: 'Choose Date',
          onTap: () => onMonthTap(displayed.month),
        ),
      ],
    );
  }
}

class _MonthChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback onTap;

  const _MonthChip({
    required this.label,
    required this.isSelected,
    this.isDisabled = false,
    required this.onTap,
  });

  @override
  State<_MonthChip> createState() => _MonthChipState();
}

class _MonthChipState extends State<_MonthChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
      lowerBound: 0.88,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTap() {
    if (widget.isDisabled) return;
    _ctrl.reverse().then((_) => _ctrl.forward());
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
        scale: _ctrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          width: 58,
          height: 38,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.primarymain
                : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: AppTextStyles.bodyXlMedium.copyWith(
              color: widget.isSelected
                  ? AppColors.white
                  : widget.isDisabled
                  ? AppColors.text100
                  : AppColors.text500,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  YEAR PANEL
// ─────────────────────────────────────────────
class _YearPanel extends StatefulWidget {
  final DateTime selected;
  final ValueChanged<int> onYearTap;
  final int firstYear;
  final int lastYear;

  const _YearPanel({
    required this.selected,
    required this.onYearTap,
    required this.firstYear,
    required this.lastYear,
  });

  @override
  State<_YearPanel> createState() => _YearPanelState();
}

class _YearPanelState extends State<_YearPanel> {
  late ScrollController _scrollCtrl;

  @override
  void initState() {
    super.initState();
    // Scroll so selected year is visible
    final yearsBeforeSelected = widget.selected.year - widget.firstYear;
    final rowIndex = (yearsBeforeSelected / 4).floor();
    final offset = rowIndex * 52.0; // 30px row + 22px gap
    _scrollCtrl = ScrollController(initialScrollOffset: offset.clamp(0, 9999));
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final years = List.generate(
      widget.lastYear - widget.firstYear + 1,
      (i) => widget.firstYear + i,
    );

    // Group into rows of 4
    final rows = <List<int>>[];
    for (int i = 0; i < years.length; i += 4) {
      rows.add(years.sublist(i, (i + 4).clamp(0, years.length)));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.text40, width: 0.7),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Year', style: AppTextStyles.bodyLargeBold),
              const SizedBox(height: 2),
              Text('Choose Year', style: AppTextStyles.captionRegular),
              const SizedBox(height: 12),
              SizedBox(
                height: 134,
                child: ListView.separated(
                  controller: _scrollCtrl,
                  physics: const BouncingScrollPhysics(),
                  itemCount: rows.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 22),
                  itemBuilder: (_, i) {
                    final row = rows[i];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: row.map((year) {
                        final isSelected = year == widget.selected.year;
                        return _YearChip(
                          year: year,
                          isSelected: isSelected,
                          onTap: () => widget.onYearTap(year),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Divider(color: AppColors.text40, thickness: 0.7),
        _SectionHeader(
          label: 'Month',
          subLabel: 'Choose Month',
          onTap: () => widget.onYearTap(widget.selected.year),
        ),
        const SizedBox(height: 4),
        Divider(color: AppColors.text40, thickness: 0.7),
        _SectionHeader(
          label: 'Date',
          subLabel: 'Choose Date',
          onTap: () => widget.onYearTap(widget.selected.year),
        ),
      ],
    );
  }
}

class _YearChip extends StatefulWidget {
  final int year;
  final bool isSelected;
  final VoidCallback onTap;

  const _YearChip({
    required this.year,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_YearChip> createState() => _YearChipState();
}

class _YearChipState extends State<_YearChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
      lowerBound: 0.88,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTap() {
    _ctrl.reverse().then((_) => _ctrl.forward());
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
        scale: _ctrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          width: 62,
          height: 30,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.primarymain
                : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          child: Text(
            '${widget.year}',
            style: AppTextStyles.bodyXlMedium.copyWith(
              color: widget.isSelected ? AppColors.white : AppColors.text500,
            ),
          ),
        ),
      ),
    );
  }
}
