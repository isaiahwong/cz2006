part of 'coordinates.dart';

class CoordinatesTile extends StatefulWidget {
  final Coordinates coordinates;
  final bool start;
  final ValueNotifier<List<WayPoint>> wayPoints;

  CoordinatesTile(
      {Key? key,
      required this.coordinates,
      required this.start,
      required this.wayPoints})
      : super(key: key);

  @override
  _CoordinatesTileState createState() => _CoordinatesTileState();
}

enum SelectedOption {
  START,
  END,
}

class _CoordinatesTileState extends State<CoordinatesTile>
    with SingleTickerProviderStateMixin {
  CoordinatesController coordinatesController = CoordinatesController.to();
  late Coordinates _coordinates;
  SelectedOption? _selectedOption;
  late Animation<double> _iconTurns;
  late AnimationController _animationController;
  late var wayPoint;

  final _kExpand = Duration(milliseconds: 200);
  final GlobalKey<CustomExpansionTileState> _expansionKey = new GlobalKey();
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: _kExpand, vsync: this);
    _iconTurns = _animationController.drive(_halfTween.chain(_easeInTween));
    _coordinates = widget.coordinates;
    _selectedOption = widget.start ? SelectedOption.START : SelectedOption.END;
    wayPoint = <WayPoint>[];
  }

  void onSelected() {
    final coordinates = coordinatesController.onSelected(_coordinates);
    setState(() {
      if (_selectedOption == SelectedOption.START) {
        //TODO Update Start
        this.wayPoint.add(
              WayPoint(
                  name: _coordinates.name,
                  latitude: _coordinates.x,
                  longitude: _coordinates.y),
            );
      } else {
        //TODO Update End
      }
    });
  }

  Widget _title() {
    return Text(
      _coordinates.name,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: coordinatesController.isSelected(_coordinates)
            ? Theme.of(context).primaryColor
            : darkGrey,
      ),
    );
  }

  Widget _trailing() {
    return RotationTransition(
      turns: _iconTurns,
      child: const Icon(
        CupertinoIcons.add_circled,
        color: primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 5),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.grey[220]),
        child: ListTile(
          title: _title(),
          trailing: _trailing(),
          onTap: () => onSelected(),
        ),
      ),
    );
  }
}
