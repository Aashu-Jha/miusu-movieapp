import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/repositories/app_repository.dart';
import 'package:miusu/domain/usecases/usecase.dart';

class UpdateLanguage extends UseCase<void, String>{
  final AppRepository _repository;

  UpdateLanguage(this._repository);

  Future<Either<AppError,void>> call(String languageCode) async {
    return await _repository.updateLanguage(languageCode);
  }
}