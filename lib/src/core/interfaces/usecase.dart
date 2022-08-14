import 'package:fpdart/fpdart.dart';

abstract class UseCase<Error, Result, Params> {
  Future<Either<Error, Result>> call({required Params params});
}
