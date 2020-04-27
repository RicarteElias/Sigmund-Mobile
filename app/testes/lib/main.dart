import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';

void main() => runApp(Gooey());

class Gooey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: GooeyCarousel(),
        ),
      ),
    );
  }
}

enum Side { left, top, right, bottom }

class GooeyCarousel extends StatefulWidget {
  final List<Widget> children;

  GooeyCarousel({this.children}) : super();

  @override
  GooeyCarouselState createState () => GooeyCarouselState();
}

class GooeyCarouselState extends State<GooeyCarousel> with SingleTickerProviderStateMixin {
  int _index = 0; // index of the base (bottom) child
  int _dragIndex; // index of the top child
  Offset _dragOffset; // starting offset of the drag
  double _dragDirection; // +1 when dragging left to right, -1 for right to left
  bool _dragCompleted; // has the drag successfully resulted in a swipe
  Image _blueImage;
  Image _redImage;
  Image _yellowImage;
  Image _blueBg;
  Image _redBg;
  Image _yellowBg;

  GooeyEdge _edge;
  Ticker _ticker;
  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    _edge = GooeyEdge(count: 25);
    _ticker = createTicker(_tick)..start();
    _blueImage = Image.network('https://firebasestorage.googleapis.com/v0/b/vgv-flutter-vignettes.appspot.com/o/gooey_edge%2FIllustration-Blue.png?alt=media&token=7a55c1fc-0cb1-4f98-bafd-81780cd42775',);
    _redImage = Image.network('https://firebasestorage.googleapis.com/v0/b/vgv-flutter-vignettes.appspot.com/o/gooey_edge%2FIllustration-Red.png?alt=media&token=69eef39d-b806-49c1-943c-1e5c5173859a',);
    _yellowImage = Image.network('https://firebasestorage.googleapis.com/v0/b/vgv-flutter-vignettes.appspot.com/o/gooey_edge%2FIllustration-Yellow.png?alt=media&token=bcd5498e-8745-43a4-8938-d9fc69d58b49',);
    _blueBg = Image.network(
      'https://firebasestorage.googleapis.com/v0/b/vgv-flutter-vignettes.appspot.com/o/gooey_edge%2FBg-Blue.png?alt=media&token=e00eaf19-3a5f-4133-a0f7-68ab7afe95ab',
      fit: BoxFit.cover,);
    _yellowBg = Image.network(
      'https://firebasestorage.googleapis.com/v0/b/vgv-flutter-vignettes.appspot.com/o/gooey_edge%2FBg-Yellow.png?alt=media&token=a012c201-a8a4-4ec2-854c-acc92c291113',
      fit: BoxFit.cover,);
    _redBg = Image.network(
      'https://firebasestorage.googleapis.com/v0/b/vgv-flutter-vignettes.appspot.com/o/gooey_edge%2FBg-Red.png?alt=media&token=bc44fec1-89fd-41d3-baca-85fadad5e5f0',
      fit: BoxFit.cover,);


    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(_blueImage.image, context);
    precacheImage(_yellowImage.image, context);
    precacheImage(_redImage.image, context);
    precacheImage(_blueBg.image, context);
    precacheImage(_yellowBg.image, context);
    precacheImage(_redBg.image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration duration) {
    _edge.tick(duration);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: _key,
        onPanDown: (details) => _handlePanDown(details, _getSize()),
        onPanUpdate: (details) => _handlePanUpdate(details, _getSize()),
        onPanEnd: (details) => _handlePanEnd(details, _getSize()),
        child: Stack(
          children: <Widget>[
            cards(_index % 3),
            _dragIndex == null
                ? SizedBox()
                : ClipPath(
              child: cards(_dragIndex % 3),
              clipBehavior: Clip.hardEdge,
              clipper: GooeyEdgeClipper(_edge, margin: 10.0),
            ),
          ],
        ));
  }

  Widget cards(int index) {
    if (index == 0) {
      return ContentCard(
        index: index,
        color: Color.fromARGB(255, 53, 101, 248),
        image: _redImage,
        background: _redBg,
      );
    }
    if (index == 1) {
      return ContentCard(
        index: index,
        color: Color.fromARGB(255, 240, 101, 79),
        image: _blueImage,
        background: _blueBg,
      );
    }
    if (index == 2) {
      return ContentCard(
        index: index,
        color: Color.fromARGB(255, 240, 147, 61),
        image: _yellowImage,
        background: _yellowBg,
      );
    }
    return Container();
  }

  Size _getSize() {
    final RenderBox box = _key.currentContext.findRenderObject();
    return box.size;
  }

  void _handlePanDown(DragDownDetails details, Size size) {
    if (_dragIndex != null && _dragCompleted) {
      _index = _dragIndex;
    }
    _dragIndex = null;
    _dragOffset = details.localPosition;
    _dragCompleted = false;
    _dragDirection = 0;

    _edge.farEdgeTension = 0.0;
    _edge.edgeTension = 0.01;
    _edge.reset();
  }

  void _handlePanUpdate(DragUpdateDetails details, Size size) {
    double dx = details.globalPosition.dx - _dragOffset.dx;

    if (!_isSwipeActive(dx)) {
      return;
    }
    if (_isSwipeComplete(dx, size.width)) {
      return;
    }

    if (_dragDirection == -1) {
      dx = size.width + dx;
    }
    _edge.applyTouchOffset(Offset(dx, details.localPosition.dy), size);
  }

  bool _isSwipeActive(double dx) {
    // check if a swipe is just starting:
    if (_dragDirection == 0.0 && dx.abs() > 20.0) {
      _dragDirection = dx.sign;
      _edge.side = _dragDirection == 1.0 ? Side.left : Side.right;
      setState(() {
        _dragIndex = _index - _dragDirection.toInt();
      });
    }
    return _dragDirection != 0.0;
  }

  bool _isSwipeComplete(double dx, double width) {
    if (_dragDirection == 0.0) {
      return false;
    } // haven't started
    if (_dragCompleted) {
      return true;
    } // already done

    // check if swipe is just completed:
    double availW = _dragOffset.dx;
    if (_dragDirection == 1) {
      availW = width - availW;
    }
    double ratio = dx * _dragDirection / availW;

    if (ratio > 0.8 && availW / width > 0.5) {
      _dragCompleted = true;
      _edge.farEdgeTension = 0.01;
      _edge.edgeTension = 0.0;
      _edge.applyTouchOffset();
    }
    return _dragCompleted;
  }

  void _handlePanEnd(DragEndDetails details, Size size) {
    _edge.applyTouchOffset();
  }
}

class ContentCard extends StatefulWidget {
  final Color color;
  final int index;
  final Widget image;
  final Widget background;

  ContentCard({this.color, this.index, this.image, this.background}) : super();

  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  Ticker _ticker;
  @override
  void initState() {
    _ticker = Ticker((d) {
      setState(() {});
    })
      ..start();
    super.initState();
  }
  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var time = DateTime.now().millisecondsSinceEpoch / 2000;
    var scaleX = 1.2 + sin(time) * .05;
    var scaleY = 1.2 + cos(time) * .07;
    var offsetY = 20 + cos(time) * 20;
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        Transform(
          transform: Matrix4.diagonal3Values(scaleX, scaleY, 1),
          child: Transform.translate(
            offset: Offset(-(scaleX - 1) / 2 * size.width, -(scaleY - 1) / 2 * size.height + offsetY),
            child: widget.background,
          ),
        ),
        Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Container(
                      child: widget.image,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                    )),
                _buildPageIndicator(this.widget.index),
              ],
            ))
      ],
    );
  }

  Widget _buildPageIndicator(int index) {
    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("SWIPE",
                        style: TextStyle(color: Colors.white)
                    ),
                    Icon(Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ]
              ),
            ),
            _indicator(0),
            SizedBox(
              width: 10,
            ),
            _indicator(1),
            SizedBox(
              width: 10,
            ),
            _indicator(2),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.arrow_back,
                      color: Colors.white,
                    ),
                    Text("SWIPE",
                        style: TextStyle(color: Colors.white)
                    ),
                  ]
              ),
            ),
          ],
        )
    );
  }

  Widget _indicator(int idx) {
    BoxDecoration _selected =
    BoxDecoration(color: Colors.white, shape: BoxShape.circle);
    BoxDecoration _unselected = BoxDecoration(
      border: Border.all(color: Colors.white),
      shape: BoxShape.circle,
    );
    return Container(
      decoration: this.widget.index == idx ? _selected : _unselected,
      height: 30,
      width: 30,
      //  width: 30,
    );
  }
}

class GooeyEdge {
  List<_GooeyPoint> points;
  Side side;
  double edgeTension = 0.01;
  double farEdgeTension = 0.0;
  double touchTension = 0.1;
  double pointTension = 0.25;
  double damping = 0.9;
  double maxTouchDistance = 0.15;
  int lastT = 0;

  FractionalOffset touchOffset;

  GooeyEdge({count = 10, this.side = Side.left}) {
    points = [];
    for (int i = 0; i < count; i++) {
      points.add(_GooeyPoint(0.0, i / (count - 1)));
    }
  }

  void reset() {
    points.forEach((pt) => pt.x = pt.velX = pt.velY = 0.0);
  }

  void applyTouchOffset([Offset offset, Size size]) {
    if (offset == null) {
      touchOffset = null;
      return;
    }
    FractionalOffset o = FractionalOffset.fromOffsetAndSize(offset, size);
    if (side == Side.left) {
      touchOffset = o;
    } else if (side == Side.right) {
      touchOffset = FractionalOffset(1.0 - o.dx, 1.0 - o.dy);
    } else if (side == Side.top) {
      touchOffset = FractionalOffset(o.dy, 1.0 - o.dx);
    } else {
      touchOffset = FractionalOffset(1.0 - o.dy, o.dx);
    }
  }

  Path buildPath(Size size, {double margin = 0.0}) {
    if (points == null || points.length == 0) {
      return null;
    }

    Matrix4 mtx = _getTransform(size, margin);

    Path path = Path();
    int l = points.length;
    Offset pt = _GooeyPoint(-margin, 1.0).toOffset(mtx), pt1;
    path.moveTo(pt.dx, pt.dy); // bl

    pt = _GooeyPoint(-margin, 0.0).toOffset(mtx);
    path.lineTo(pt.dx, pt.dy); // tl

    pt = points[0].toOffset(mtx);
    path.lineTo(pt.dx, pt.dy); // tr

    pt1 = points[1].toOffset(mtx);
    path.lineTo(pt.dx + (pt1.dx - pt.dx) / 2, pt.dy + (pt1.dy - pt.dy) / 2);

    for (int i = 2; i < l; i++) {
      pt = pt1;
      pt1 = points[i].toOffset(mtx);
      double midX = pt.dx + (pt1.dx - pt.dx) / 2;
      double midY = pt.dy + (pt1.dy - pt.dy) / 2;
      path.quadraticBezierTo(pt.dx, pt.dy, midX, midY);
    }

    path.lineTo(pt1.dx, pt1.dy); // br
    path.close(); // bl

    return path;
  }

  void tick(Duration duration) {
    if (points == null || points.length == 0) {
      return;
    }
    int l = points.length;
    double t = min(1.5, (duration.inMilliseconds - lastT) / 1000 * 60);
    lastT = duration.inMilliseconds;
    double dampingT = pow(damping, t);

    for (int i = 0; i < l; i++) {
      _GooeyPoint pt = points[i];
      pt.velX -= pt.x * edgeTension * t;
      pt.velX += (1.0 - pt.x) * farEdgeTension * t;
      if (touchOffset != null) {
        double ratio =
        max(0.0, 1.0 - (pt.y - touchOffset.dy).abs() / maxTouchDistance);
        pt.velX += (touchOffset.dx - pt.x) * touchTension * ratio * t;
      }
      if (i > 0) {
        _addPointTension(pt, points[i - 1].x, t);
      }
      if (i < l - 1) {
        _addPointTension(pt, points[i + 1].x, t);
      }
      pt.velX *= dampingT;
    }

    for (int i = 0; i < l; i++) {
      _GooeyPoint pt = points[i];
      pt.x += pt.velX * t;
    }
  }

  Matrix4 _getTransform(Size size, double margin) {
    bool vertical = side == Side.top || side == Side.bottom;
    double w = (vertical ? size.height : size.width) + margin * 2;
    double h = (vertical ? size.width : size.height) + margin * 2;

    Matrix4 mtx = Matrix4.identity()
      ..translate(-margin, 0.0)
      ..scale(w, h);
    if (side == Side.top) {
      mtx
        ..rotateZ(pi / 2)
        ..translate(0.0, -1.0);
    } else if (side == Side.right) {
      mtx
        ..rotateZ(pi)
        ..translate(-1.0, -1.0);
    } else if (side == Side.bottom) {
      mtx
        ..rotateZ(pi * 3 / 2)
        ..translate(-1.0, 0.0);
    }

    return mtx;
  }

  void _addPointTension(_GooeyPoint pt0, double x, double t) {
    pt0.velX += (x - pt0.x) * pointTension * t;
  }
}

class _GooeyPoint {
  double x;
  double y;
  double velX = 0.0;
  double velY = 0.0;

  _GooeyPoint([this.x = 0.0, this.y = 0.0]);

  Offset toOffset([Matrix4 transform]) {
    Offset o = Offset(x, y);
    if (transform == null) {
      return o;
    }
    return MatrixUtils.transformPoint(transform, o);
  }
}

class GooeyEdgeClipper extends CustomClipper<Path> {
  GooeyEdge edge;
  double margin;

  GooeyEdgeClipper(this.edge, {this.margin = 0.0}) : super();

  @override
  Path getClip(Size size) {
    return edge.buildPath(size, margin: margin);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

