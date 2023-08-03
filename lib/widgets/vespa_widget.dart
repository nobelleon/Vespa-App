import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:vespa_app/core/constants.dart';

class VespaWidget extends StatefulWidget {
  final double vespaDragPercent;

  const VespaWidget({Key key, this.vespaDragPercent}) : super(key: key);

  @override
  _VespaWidgetState createState() => _VespaWidgetState();
}

class _VespaWidgetState extends State<VespaWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _slideInAnimationController;
  Animation<double> _slideInAnimation;

  Offset _vespaOffset = const Offset(0, 0);
  Offset _centerTextOffset = const Offset(0, 0);
  Offset _cardOffset = const Offset(1, -.2);
  double _bottomTextPosY = 120;

  // proses animasi bergerak
  @override
  void initState() {
    _slideInAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 2200,
      ),
    )
      ..addListener(() {
        setState(() {
          _vespaOffset = Offset(-1 + _slideInAnimation.value, 0);
          _centerTextOffset = Offset(1 - _slideInAnimation.value, 0);
          _bottomTextPosY = 70 + (50 * _slideInAnimation.value);
        });
      })
      ..forward();
    _slideInAnimation = CurvedAnimation(
        parent: _slideInAnimationController, curve: Curves.ease);
    super.initState();
  }

  @override
  void dispose() {
    _slideInAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(VespaWidget oldWidget) {
    final double dragPercent = widget.vespaDragPercent;
    // efek kedalam jika di drag
    if (oldWidget.vespaDragPercent != dragPercent) {
      _vespaOffset = Offset(-.3 * dragPercent, -.3 * dragPercent);
      // efek lebih kedalam ( tulisan Piagio tersembunyi )
      _bottomTextPosY = bottomTextSpacing +
          (-(bottomTextSpacing + spacingFactor(3)) * dragPercent);
      // efek geser kesamping
      _cardOffset = Offset(1 - dragPercent, (1 - dragPercent) * -.2);
    }
    super.didUpdateWidget(oldWidget);
  }

  // method Text Vespa
  Widget buildCenterText() {
    return FractionalTranslation(
      translation: _centerTextOffset,
      child: Transform.scale(
        // efek pada tulisan vespa
        scale: 1.0 - widget.vespaDragPercent.clamp(0.0, 0.1),
        child: Center(
          child: GradientText(
            'Vespa',
            colors: [Colors.purple[500], Colors.cyan], // textGradientColor
            gradientDirection: GradientDirection.ttb,
            style: const TextStyle(
              fontSize: 135, // 165, 125
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // method image vespa
  Widget _buildVespaImg(double tinggi) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: tinggi * .26,
      child: FractionalTranslation(
        translation: _vespaOffset,
        child: Transform.scale(
          // efek gambar vespa lebih besar jika di drag
          scale: 1 + (widget.vespaDragPercent / 2),
          child: Image.asset("assets/images/Piaggio_Vespa_946_Blue.png"),
        ),
      ),
    );
  }

  Widget _buildBottomText() {
    return Positioned(
      // judul text dibawah
      bottom: _bottomTextPosY,
      child: titleText,
    );
  }

  // Ruang tombol power
  Widget _buildBottomCard() {
    return FractionalTranslation(
      // efek geser kesamping _cardOffset
      translation: _cardOffset,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 90,
          margin: const EdgeInsets.all(defaultSpacing),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(defaultBorderRadius * 2),
          ),
          child: Row(
            children: [
              // efek tombol power mengecil saat di drag
              Transform.scale(
                scale: widget.vespaDragPercent,
                child: Container(
                  width: 100,
                  height: 90,
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: gradientColors,
                    //   begin: Alignment.bottomCenter,
                    //   end: Alignment.topCenter,
                    // ),
                    // efek mengecil membulat saat di drag
                    borderRadius: BorderRadius.circular(
                      defaultBorderRadius +
                          (1 - widget.vespaDragPercent) *
                              (defaultBorderRadius * 4),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/power_2.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: spacingFactor(1),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 1.0),
                child: Row(
                  children: const [
                    Text(
                      "Geser untuk menutup",
                      style: TextStyle(
                        fontSize: 20, //24 ,16
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: defaultSpacing),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.cyan,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double tinggi = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      children: [
        buildCenterText(),
        _buildVespaImg(tinggi),
        _buildBottomText(),
        _buildBottomCard(),
      ],
    );
  }
}
