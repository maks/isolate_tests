import 'dart:isolate';
import 'dart:io';

Future worker(int id) async {
  if (id % 100 == 0) {
    stdout.write('.');
  }
  // Keep the workers alive to see memory impact of having N isolates alive at
  // the same time.
  await Future.delayed(const Duration(seconds: 5));
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
}

// ref: https://github.com/dart-lang/sdk/commit/9ce608e89d6b68d84f529fd9dab18f2bc61f5a8e
void printMemUsage() {
  final currentRss = ProcessInfo.currentRss;
  final maxRss = ProcessInfo.maxRss;
  print('RSS current:$currentRss max:$maxRss');
}

Future spawn(int id) async {
  // print('spawning a worker: $id');
  await Isolate.spawn(worker, id);
  // print('spawned an isolate');
  // printMemUsage();
}
