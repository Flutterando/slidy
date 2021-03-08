import 'package:dartz/dartz.dart';

abstract class IGetUserListUseCase {
  Future<Either<GetUserListUseCaseFailure, List<GetUserListUseCase>>> call();
}

class GetUserListUseCase extends IGetUserListUseCase { 

  GetUserListUseCase(this.repository);

  @override
  Future<Either<GetUserListUseCaseFailure, List<GetUserListUseCase>>> call() async {
    throw NotImplementedException();
  }
}