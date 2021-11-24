import 'package:amer_school/App/Core/errors/App_Error.dart';
import 'package:dartz/dartz.dart';

abstract class UseCases<Type, Params>{
   Future<Either<AppError, Type>> call(Params params);
}

//Type---- What does the Use Case Return.

//Params ---------- what is Required to call Api.