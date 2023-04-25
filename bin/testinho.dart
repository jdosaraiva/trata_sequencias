import 'dart:math';
import 'dart:io';

void main(List<String> args) {
  var stringRandomica = randomString(10);

  print(stringRandomica); // imprime uma string aleatória de tamanho 10

  Process.runSync('cmd', ['/c', 'echo', stringRandomica.trim(), '|', 'clip']);
}

String randomString(int length) {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
}
