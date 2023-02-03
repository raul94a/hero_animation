import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main(List<String> args) {
  runApp(const FabHeroDemo());
}

class FabHeroDemo extends StatelessWidget {
  const FabHeroDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: const MainPage());
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _toPage(context),
        child: Builder(builder: (context) {
          return Material(
            child: Material(child: Icon(Icons.navigate_next_outlined)),
          );
        }),
      ),
      body: ListView(
        children: [
          ...List.generate(
              5,
              (index) => CircleAvatar(
                    backgroundColor: getColor(index),
                    radius: 75,
                  )),
            Hero(
              tag: 'hero-fab',
              child: Visibility(
                visible: true,
                child: ElevatedButton(onPressed: (){}, child: Text('HERO'))),
            )
          //  Hero(tag: 'hero-fab', child: CircularProgressIndicator())
        ],
      ),
    );
  }

  Color getColor(int index) {
    if (isDivisibleBy(index, 2)) {
      return Colors.black;
    } else if (isDivisibleBy(index, 3)) {
      return Colors.red;
    } else if (isDivisibleBy(index, 5)) {
      return Colors.green;
    } else if (isDivisibleBy(index, 7)) {
      return Colors.amber;
    } else {
      return Colors.lightBlue;
    }
  }

  bool isDivisibleBy(int number, int divisor) {
    return number % divisor == 0;
  }

  void _toPage(BuildContext context) {
    final opacity = Interval(0, 0.75, curve: Curves.fastLinearToSlowEaseIn);
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (ctx, animation, secondary) {
          return AnimatedBuilder(
              animation: animation,
              builder: (ctx, _) => Opacity(
                  opacity: opacity.transform(animation.value),
                  child: const SecondaryPage()));
        }));
  }
}

class SecondaryPage extends StatelessWidget {
  const SecondaryPage({super.key});

 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Hero(
      tag: 'hero-fab',
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Builder(builder: (context) {
          return ListView(children: [
            Material(
              child: InkWell(
                onTap: Navigator.of(context).pop,
                child: Image.asset(
                  'assets/dog3.jpg',
                  width: size.width, 
                  height: 250,
                  fit: BoxFit.fill, 
                ),
              ),
            ),
            Material(
              child: SizedBox(
                height: size.height * 0.0,
                child: Wrap(
                  children: List.generate(
                      00,
                      (index) => ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: index % 2 == 0
                                  ? Colors.blue
                                  : index % 3 == 0
                                      ? Colors.red
                                      : Colors.greenAccent,
                            ),
                            title: Text('Item number ${index + 1}'),
                            subtitle: Text('Subtitle number ${index + 1}'),
                          )),
                ),
              ),
            )
          ]);
        }),
      ),
    );
  }
}
