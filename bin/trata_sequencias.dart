import 'dart:io';

void main() {
  stdin.echoMode = false;
  stdin.lineMode = false;

  String input = '';

  stdout.write('> ');
  while (true) {
    int byte = stdin.readByteSync();

    if (byte == 3) {
      // Ctrl+C
      break;
    } else if (byte == 22) {
      // Ctrl+V
      input += getClipboardData();
    } else if (byte == 10 || byte == 13) {
      // Enter
      // print('\nInput: $input');
      if (input.isEmpty) {
        stdout.write('\n> ');
        continue;
      }

      if (input == 'tchau' ||
          input == 'bye' ||
          input == 'exit' ||
          input == 'quit') {
        print('\nPrograma encerrado!');
        break;
      }

      print('\nOutput: ${tratarString(input)}');
      stdout.write('> ');
      input = '';
    } else {
      stdout.write(String.fromCharCode(byte));
      input += String.fromCharCode(byte);
    }
  }
}

String tratarString(String input) {
  // Aqui você pode adicionar a lógica para tratar a string recebida
  // e retornar o resultado desejado

  String minhaString = input;
  String minhaStringSemCaracteres =
      minhaString.replaceAll(RegExp(r'[().+\-]'), '').trim();
  // print(minhaStringSemCaracteres);

  minhaStringSemCaracteres = minhaStringSemCaracteres.trim();
  // print('minhaStringSemCaracteres: $minhaStringSemCaracteres');

  var elementos = minhaStringSemCaracteres.split(RegExp(r'\s+'));

  var resultado = '';
  for (var elemento in elementos) {
    String result = elemento.replaceAllMapped(RegExp(r"0+$"), (match) {
      int? tamanho = match.group(0)?.length;
      if (tamanho == 1) {
        return "%";
      } else if (tamanho == 2) {
        return "%";
      } else {
        String zeros = '';
        for (int i = 1; i <= (tamanho! - 2); i++) {
          zeros += '0';
        }
        return '$zeros%';
      }
    });

    resultado += '"$result", ';
  }

  resultado = resultado.toUpperCase().trim();
  resultado = resultado.substring(0, resultado.length - 1);

  copyToClipboard(resultado);

  return resultado;
}

String getClipboardData() {
  if (Platform.isWindows) {
    return Process.runSync('powershell', ['Get-Clipboard']).stdout.toString();
  } else if (Platform.isMacOS || Platform.isLinux) {
    return Process.runSync('pbpaste', []).stdout.toString();
  } else {
    return '';
  }
}

void copyToClipboard(String text) {
  if (Platform.isWindows) {
    // Copia o texto para a área de transferência do Windows
    Process.runSync('cmd', ['/c', 'echo', text.trim(), '|', 'clip']);
  }
}
