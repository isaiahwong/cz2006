part of 'exercise.dart';

class ExerciseTile extends StatefulWidget {
  final Exercise exercise;

  ExerciseTile({Key? key, required this.exercise}) : super(key: key);

  @override
  _ExerciseTileState createState() => _ExerciseTileState();
}

enum SelectedOption {
  WARMUPS,
  SETS,
  REPS,
  REST,
}

class _ExerciseTileState extends State<ExerciseTile>
    with SingleTickerProviderStateMixin {
  ExerciseController exerciseController = ExerciseController.to();
  late Exercise _exercise;

  late Animation<double> _iconTurns;
  late AnimationController _animationController;

  final _kExpand = Duration(milliseconds: 200);
  final GlobalKey<CustomExpansionTileState> _expansionKey = new GlobalKey();
  SelectedOption? _selectedOption;

  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: _kExpand, vsync: this);
    _iconTurns = _animationController.drive(_halfTween.chain(_easeInTween));
    _exercise = widget.exercise;
  }

  void onSelected(bool expanded) {
    /// Rotates ExpandedTile leading icon
    if (expanded)
      _animationController.forward();
    else
      _animationController.reverse();
    final exercise = exerciseController.onSelected(_exercise);
    setState(() {
      _exercise = exercise ?? _exercise;
    });
  }

  Widget _title() {
    return Text(
      _exercise.name,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: exerciseController.isSelected(_exercise)
            ? Theme.of(context).primaryColor
            : darkGrey,
      ),
    );
  }

  Widget _trailing() {
    return exerciseController.isSelected(_exercise)
        ? RotationTransition(
            turns: _iconTurns,
            child: const Icon(Icons.expand_more),
          )
        : const Icon(
            CupertinoIcons.add_circled,
            color: primaryColor,
          );
  }

  Widget _warmupItem() {
    return ListTile(
      title: Text(
        'Warmups',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.w400),
      ),
      trailing: NumberScroller(
        maxValue: 11,
        initialValue: _exercise.defaultWarmups,
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedOption == SelectedOption.WARMUPS
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        onChanged: (w) {
          exerciseController.onChanged(exercise: _exercise, warmups: w);
          if (_selectedOption != SelectedOption.WARMUPS)
            setState(() => _selectedOption = SelectedOption.WARMUPS);
        },
      ),
    );
  }

  Widget _setItem() {
    return ListTile(
      title: Text(
        'Sets',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.w400),
      ),
      trailing: NumberScroller(
        maxValue: 99,
        minValue: 1,
        initialValue: _exercise.defaultSets,
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedOption == SelectedOption.SETS
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        onChanged: (s) {
          exerciseController.onChanged(exercise: _exercise, sets: s);
          if (_selectedOption != SelectedOption.SETS)
            setState(() => _selectedOption = SelectedOption.SETS);
        },
      ),
    );
  }

  Widget _repsItem() {
    return ListTile(
      title: Text(
        'Reps',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.w400),
      ),
      trailing: NumberScroller(
        maxValue: 99,
        minValue: 1,
        initialValue: _exercise.defaultReps,
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedOption == SelectedOption.REPS
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        onChanged: (r) => setState(() {
          exerciseController.onChanged(exercise: _exercise, reps: r);
          if (_selectedOption != SelectedOption.REPS)
            _selectedOption = SelectedOption.REPS;
        }),
      ),
    );
  }

  Widget _restItem() {
    return ListTile(
      title: Text(
        'Rest',
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.w400),
      ),
      trailing: Container(
        width: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NumberScroller(
              maxValue: 21,
              initialValue: _exercise.defaultRestMinutes,
              width: 35,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedOption == SelectedOption.REST
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              onChanged: (m) => setState(() {
                exerciseController.onChanged(
                  exercise: _exercise,
                  minutes: m,
                  seconds: _exercise.defaultRestSeconds,
                );
                if (_selectedOption != SelectedOption.REST)
                  _selectedOption = SelectedOption.REST;
              }),
            ),
            SizedBox(
              width: 6,
            ),
            NumberScroller(
              maxValue: 61,
              initialValue: _exercise.defaultRestSeconds,
              twoDP: true,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedOption == SelectedOption.REST
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              onChanged: (s) => setState(() {
                exerciseController.onChanged(
                  exercise: _exercise,
                  seconds: s,
                  minutes: _exercise.defaultRestMinutes,
                );
                if (_selectedOption != SelectedOption.REST)
                  _selectedOption = SelectedOption.REST;
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _removeButton() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: CustomButton(
        "REMOVE",
        width: double.infinity,
        radius: 20,
        height: 32,
        textColor: Colors.white,
        backgroundColor: red,
        onPressed: () {
          _expansionKey.currentState!.toggle();
          exerciseController.onRemove(_exercise);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 5),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.grey[220]),
        child: CustomExpansionTile(
          key: _expansionKey, // Refreshes state to collapse
          title: _title(),
          onExpansionChanged: (expanded) => onSelected(expanded),
          trailing: _trailing(),
          children: <Widget>[
            _warmupItem(),
            _setItem(),
            _repsItem(),
            _restItem(),
            SizedBox(height: 20),
            _removeButton(),
          ],
        ),
      ),
    );
  }
}
