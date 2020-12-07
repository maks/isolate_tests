# Tests for Dart Isolates


## Using


Compile using:
`/usr/bin/dart --enable-isolate-groups compile aot-snapshot  bin/main.dart`


## Results:

run on: Dell 5400 Chromebook i7-8665U in a Debian10 Crostini container

`Dart SDK version: 2.12.0-110.0.dev (dev) (Unknown timestamp) on "linux_x64")` 

### The dot basic test

Baseline:
```
/usr/lib/dart/bin/dartaotruntime  bin/main.aot 10000
RSS current:10256384 max:10256384
....................................................................................................time: 20460
RSS current:67088384 max:71393280
```

With improvements from #36097
```
/usr/lib/dart/bin/dartaotruntime --enable-isolate-groups  bin/main.aot 10000
RSS current:10403840 max:10403840
....................................................................................................time: 3485
RSS current:27586560 max:28921856
```

*Note:* Used dartaotruntime from an old Dart SDK inside an old Flutter 1.20 I had already installed as couldn't find  