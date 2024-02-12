import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as p;

String _join(String path1, String path2) {
  return path1 + Platform.pathSeparator + path2;
}

void main() {
  final libDirectory = Directory('lib');
  final exportFilePath = _join('lib', 'mix.dart');

  if (!libDirectory.existsSync()) {
    log('The lib directory was not found.');

    return;
  }

  final exportFile = File(exportFilePath);
  if (exportFile.existsSync()) {
    exportFile.deleteSync();
  }

  final outputString = StringBuffer();

  outputString
      .writeln('/// This file is generated by the update_exports.dart script.');
  outputString.writeln('/// DO NOT MODIFY MANUALLY');
  outputString.writeln('');
  outputString.writeln('library mix;');
  outputString.writeln('');

  outputString.writeln('// Automated file exports');

  final filesList = libDirectory.listSync(recursive: true);

  // Order the files alphabetically
  filesList.sort((a, b) => a.path.compareTo(b.path));

  // Traverse the /lib/ directory
  for (final entity in filesList) {
    // Get the relative path using the path package
    final relativePath = p.relative(entity.path, from: libDirectory.path);

    if (relativePath.startsWith(_join('src', 'helpers'))) {
      continue;
    }

    if (!relativePath.endsWith('.dart')) {
      continue;
    }

    if (relativePath.startsWith('mix.dart')) {
      continue;
    }

    outputString.writeln('export \'$relativePath\';');
  }

  exportFile.writeAsStringSync(outputString.toString());

  log('Exports file updated with ${outputString.length} exports.');
}
