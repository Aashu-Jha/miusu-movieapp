import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/repositories/app_repository.dart';
import 'file:///C:/Users/Aashish%20Jha/StudioProjects/miusu/lib/domain/entities/no_params.dart';
import 'package:miusu/domain/usecases/usecase.dart';

class GetPreferredLanguage extends UseCase<String, NoParams>{
  final AppRepository _repository;

  GetPreferredLanguage(this._repository);

  Future<Either<AppError,String>> call(NoParams noParams) async {
    return await _repository.getPreferredLanguage();
  }
}