import 'package:dartz/dartz.dart';

abstract class UseCase<Error, Result, Params> {
  Future<Either<Error, Result>> call({required Params params});
}
