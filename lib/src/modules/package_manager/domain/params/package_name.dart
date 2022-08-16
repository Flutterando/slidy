class PackageName {
  final String name;
  final bool isDev;
  final String version;

  PackageName(this.name, {this.isDev = false, this.version = ''});

  PackageName copyWith({
    String? name,
    bool? isDev,
    String? version,
  }) {
    return PackageName(
      name ?? this.name,
      isDev: isDev ?? this.isDev,
      version: version ?? this.version,
    );
  }
}
