import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class CustomFile implements File {
  final String yaml;
  final File _file;

  CustomFile({required this.yaml}) : _file = File(yaml);
  @override
  File get absolute => _file.absolute;

  @override
  Future<File> copy(String newPath) {
    return _file.copy(newPath);
  }

  @override
  File copySync(String newPath) {
    return _file.copySync(newPath);
  }

  @override
  Future<File> create({bool recursive = false}) {
    return _file.create(recursive: recursive);
  }

  @override
  void createSync({bool recursive = false}) {
    _file.createSync(recursive: recursive);
  }

  @override
  Future<FileSystemEntity> delete({bool recursive = false}) {
    return _file.delete(recursive: recursive);
  }

  @override
  void deleteSync({bool recursive = false}) {
    _file.deleteSync(recursive: recursive);
  }

  @override
  Future<bool> exists() {
    return Future.value(true);
  }

  @override
  bool existsSync() {
    return true;
  }

  @override
  bool get isAbsolute => _file.isAbsolute;

  @override
  Future<DateTime> lastAccessed() {
    return _file.lastAccessed();
  }

  @override
  DateTime lastAccessedSync() {
    return _file.lastAccessedSync();
  }

  @override
  Future<DateTime> lastModified() {
    return _file.lastModified();
  }

  @override
  DateTime lastModifiedSync() {
    return _file.lastModifiedSync();
  }

  @override
  Future<int> length() {
    return _file.length();
  }

  @override
  int lengthSync() {
    return _file.lengthSync();
  }

  @override
  Future<RandomAccessFile> open({FileMode mode = FileMode.read}) {
    return _file.open(mode: mode);
  }

  @override
  Stream<List<int>> openRead([int? start, int? end]) {
    return _file.openRead(start, end);
  }

  @override
  RandomAccessFile openSync({FileMode mode = FileMode.read}) {
    return _file.openSync(mode: mode);
  }

  @override
  IOSink openWrite({FileMode mode = FileMode.write, Encoding encoding = utf8}) {
    return _file.openWrite(encoding: encoding, mode: mode);
  }

  @override
  Directory get parent => _file.parent;

  @override
  String get path => _file.path;

  @override
  Future<Uint8List> readAsBytes() {
    return _file.readAsBytes();
  }

  @override
  Uint8List readAsBytesSync() {
    return _file.readAsBytesSync();
  }

  @override
  Future<List<String>> readAsLines({Encoding encoding = utf8}) {
    return _file.readAsLines(encoding: encoding);
  }

  @override
  List<String> readAsLinesSync({Encoding encoding = utf8}) {
    return _file.readAsLinesSync(encoding: encoding);
  }

  @override
  Future<String> readAsString({Encoding encoding = utf8}) {
    return Future.value(yaml);
  }

  @override
  String readAsStringSync({Encoding encoding = utf8}) {
    return yaml;
  }

  @override
  Future<File> rename(String newPath) {
    // TODO: implement rename
    throw UnimplementedError();
  }

  @override
  File renameSync(String newPath) {
    // TODO: implement renameSync
    throw UnimplementedError();
  }

  @override
  Future<String> resolveSymbolicLinks() {
    // TODO: implement resolveSymbolicLinks
    throw UnimplementedError();
  }

  @override
  String resolveSymbolicLinksSync() {
    // TODO: implement resolveSymbolicLinksSync
    throw UnimplementedError();
  }

  @override
  Future setLastAccessed(DateTime time) {
    // TODO: implement setLastAccessed
    throw UnimplementedError();
  }

  @override
  void setLastAccessedSync(DateTime time) {
    // TODO: implement setLastAccessedSync
  }

  @override
  Future setLastModified(DateTime time) {
    // TODO: implement setLastModified
    throw UnimplementedError();
  }

  @override
  void setLastModifiedSync(DateTime time) {
    // TODO: implement setLastModifiedSync
  }

  @override
  Future<FileStat> stat() {
    // TODO: implement stat
    throw UnimplementedError();
  }

  @override
  FileStat statSync() {
    // TODO: implement statSync
    throw UnimplementedError();
  }

  @override
  // TODO: implement uri
  Uri get uri => throw UnimplementedError();

  @override
  Stream<FileSystemEvent> watch({int events = FileSystemEvent.all, bool recursive = false}) {
    // TODO: implement watch
    throw UnimplementedError();
  }

  @override
  Future<File> writeAsBytes(List<int> bytes, {FileMode mode = FileMode.write, bool flush = false}) {
    // TODO: implement writeAsBytes
    throw UnimplementedError();
  }

  @override
  void writeAsBytesSync(List<int> bytes, {FileMode mode = FileMode.write, bool flush = false}) {
    // TODO: implement writeAsBytesSync
  }

  @override
  Future<File> writeAsString(String contents, {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) {
    // TODO: implement writeAsString
    throw UnimplementedError();
  }

  @override
  void writeAsStringSync(String contents, {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) {
    // TODO: implement writeAsStringSync
  }
}
