abstract class StorageDatasource<T> {
  Future<void> removeAll();
  Future<void> signOut();
}
