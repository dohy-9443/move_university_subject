abstract class IUseCase<Type, Params> {
  Future<Type> call(Params params);
}