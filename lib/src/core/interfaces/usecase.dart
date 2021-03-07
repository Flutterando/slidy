import 'package:either_dart/either.dart';

abstract class UseCase<Error, Result, Params> {
  Future<Either<Error, Result>> call({required Params params});
}
