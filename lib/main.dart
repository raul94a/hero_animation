import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hero_animation/radial_expansion.dart';

void main() {
  runApp(const MyApp());
}

const kMinRadius = 32.0;
const kMaxRadius = 128.0;

//entrypoint
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const HeroDemo());
  }
}

class HeroDemo extends StatelessWidget {
  const HeroDemo({super.key});

  static const List<String> _assets = [
    'dog',
    'dog2',
    'dog3',
    'dog4',
    'cat',
    'cat2',
    'cat3',
    'cat4'
  ];

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.2;
    return Scaffold(
        appBar: AppBar(title: const Text('Hero animation')),
        body: Builder(builder: (ctx) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Icon(
                Icons.catching_pokemon,
                color: Color.fromRGBO(224, 22, 22, 0.996),
                size: 200,
              )),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: kMaxRadius *2,
          
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _assets.length,
                    itemBuilder: (ctx, index) =>
                        Picture(photo: _assets[index], tag: _assets[index])),
              )
            ],
          );
        }));
  }
}

class Picture extends StatelessWidget {
  const Picture({super.key, required this.photo, required this.tag});
  final String tag;
  final String photo;
  @override
  Widget build(BuildContext context) {
    return Hero(
      createRectTween: _createRectTween,
      tag: tag,
      child: Material(
        child: InkWell(
          onTap: () => toHeroPage(context, photo, tag),
          child: Image.asset(
            'assets/$photo.jpg',
            width: 250,
            alignment: Alignment.center,
            height: 250,
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }

  void toHeroPage(BuildContext context, String photo, String tag) {
    const opacityCurve = Interval(0, 0.75, curve: Curves.fastOutSlowIn);
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 900),
        pageBuilder: (context, animation, secondaryAnimation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Opacity(
                  opacity: opacityCurve.transform(animation.value),
                  child: HeroPage(photo: photo, tag: tag));
            },
          );
        },
      ),
    );
  }
}

class HeroPage extends StatelessWidget {
  const HeroPage({Key? key, required this.photo, required this.tag})
      : super(key: key);
  final String tag;
  final String photo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Hero animation - Big picture')),
      body: ListView(
        children: [
          SizedBox(
            height: kMaxRadius *2,
            width: kMaxRadius *2,
            child: Hero(
              createRectTween: _createRectTween,
              tag: tag,
              child: Material(
                child: InkWell(
                  onTap: Navigator.of(context).pop,
                  child: Image.asset(
                    'assets/$photo.jpg',
                    width: double.infinity,
                    height: size.height * 0.35,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(lorem),
          )
        ],
      ),
    );
  }
}

//global stuff I am using



RectTween _createRectTween(Rect? begin, Rect? end) {
  return MaterialRectCenterArcTween(begin: begin, end: end);
}

String lorem =
    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean accumsan nunc sed sagittis feugiat. Suspendisse efficitur enim nulla, aliquet ultrices elit dapibus et. Sed pharetra tempus hendrerit. Proin quis diam quis massa molestie faucibus nec sed felis. Integer facilisis, magna et euismod scelerisque, dui dui feugiat tortor, ultrices mollis nisi mauris nec leo. Mauris ultricies tellus eu odio pretium, eu venenatis leo cursus. Donec iaculis posuere quam in suscipit.

Sed dui dui, placerat eu dolor ullamcorper, molestie laoreet ligula. In accumsan ante dictum fringilla sollicitudin. Maecenas nec feugiat leo. Nunc tempus rhoncus aliquam. Quisque consectetur condimentum ligula a dictum. Fusce aliquam ac justo vitae condimentum. Nulla vitae feugiat lorem. In id sodales felis. Vestibulum et hendrerit nibh, eget bibendum nisl. Phasellus suscipit euismod tincidunt. Pellentesque orci lorem, maximus in vulputate quis, elementum vel diam. Vestibulum egestas orci id felis egestas, tempor rutrum purus gravida. Cras eget mauris quam. Cras arcu erat, auctor ut erat sed, efficitur efficitur orci. Nam eget augue vel ipsum euismod finibus.

Praesent rutrum augue urna, in tristique tortor aliquam varius. Nulla ornare consequat enim at lacinia. Quisque in odio sagittis, suscipit augue nec, vestibulum tortor. Proin ac sodales augue, sed facilisis elit. Mauris in vulputate diam, nec vulputate magna. Donec mauris tortor, finibus at lorem id, ornare laoreet lacus. Nulla sit amet eros eget massa facilisis porta eu eget nulla.

Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Suspendisse gravida turpis metus, pellentesque aliquet urna imperdiet ac. Sed accumsan quis tortor id auctor. Integer finibus ante quis porttitor rhoncus. Phasellus feugiat aliquam fermentum. Nullam nisl nulla, sagittis ac magna quis, luctus placerat lectus. Quisque malesuada vehicula efficitur. Sed porttitor mollis velit, eleifend dapibus urna fringilla sed.

Praesent venenatis vulputate ipsum, non pellentesque leo tempus ut. Quisque at nulla dui. Nullam egestas finibus libero, et rhoncus ante efficitur posuere. Quisque consequat tincidunt mi. Proin at enim finibus, vehicula purus id, efficitur dui. Mauris dictum risus consequat, tempus justo varius, efficitur ante. Phasellus vitae dictum est. Nullam laoreet sed lorem eget imperdiet. Proin sit amet massa consectetur, elementum risus a, pretium nisi.''';
