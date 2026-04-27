// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:isolate';
import 'dart:math';

void main() async {
  print('Main isolate started.');

  final ReceivePort mainReceivePort = ReceivePort();

  final Isolate workerIsolate = await Isolate.spawn(
    randomNumberWorker,
    mainReceivePort.sendPort,
  );

  SendPort? workerSendPort;
  int totalSum = 0;

  await for (final message in mainReceivePort) {
    if (message is SendPort) {
      workerSendPort = message;
      print('Worker isolate connected.');
    } else if (message is int) {
      totalSum += message;

      print('Received number: $message');
      print('Current sum: $totalSum');
      print('--------------------------');

      if (totalSum > 100) {
        print('Sum exceeded 100.');
        print('Sending stop command to worker isolate...');

        workerSendPort?.send('stop');

        mainReceivePort.close();
        workerIsolate.kill(priority: Isolate.immediate);

        print('Main isolate finished.');
        break;
      }
    }
  }
}

void randomNumberWorker(SendPort mainSendPort) {
  final ReceivePort workerReceivePort = ReceivePort();
  final Random random = Random();

  bool isRunning = true;
  Timer? timer;

  mainSendPort.send(workerReceivePort.sendPort);

  timer = Timer.periodic(
    const Duration(seconds: 1),
    (_) {
      if (!isRunning) {
        return;
      }

      final int randomNumber = random.nextInt(20) + 1;
      mainSendPort.send(randomNumber);
    },
  );

  workerReceivePort.listen((message) {
    if (message == 'stop') {
      isRunning = false;
      timer?.cancel();
      workerReceivePort.close();

      print('Worker isolate stopped gracefully.');

      Isolate.exit();
    }
  });
}