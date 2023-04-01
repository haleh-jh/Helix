abstract class UseCase<T, P, S>{
  Future<T> call({required P params, required S path});
}