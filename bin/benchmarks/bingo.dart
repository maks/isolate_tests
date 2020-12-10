import 'dart:isolate';
import 'dart:io';

import 'dart:math';

void worker(int id) async {
  while (true) {
    final x = Random().nextInt(1000) * Random().nextInt(1000);
    if (x == 2428) {
      print('BINGO!');
    }
    await Future.delayed(Duration(seconds: 1));
  }
}

void main(List<String> arguments) async {
  printMemUsage();
  final isoCount = int.parse(arguments[0]);
  final timer = Stopwatch()..start();
  for (var i = 0; i < isoCount; i += 1) {
    await spawn(i);
  }
  timer.stop();
  print('time: ${timer.elapsedMilliseconds}');
  printMemUsage();

  var i = 1;
  while (true) {
    await Future.delayed(Duration(seconds: 1));
    if ((i % 10) == 0) {
      printMemUsage();
    }
    stdout.write('.');
    i++;
  }
}

// ref: https://github.com/dart-lang/sdk/commit/9ce608e89d6b68d84f529fd9dab18f2bc61f5a8e
void printMemUsage() {
  final currentRss = ProcessInfo.currentRss;
  final maxRss = ProcessInfo.maxRss;
  print('RSS current:$currentRss max:$maxRss');
}

void spawn(int id) async {
  await Isolate.spawn(worker, id);
}
