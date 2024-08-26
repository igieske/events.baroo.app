part of 'local_storage_bloc.dart';

@immutable
class LocalStorageState {
  final Map<String, dynamic> data;

  const LocalStorageState({ this.data = const <String, dynamic>{} });

  LocalStorageState update(Map<String, dynamic> newValue) {
    print('update!');
    final Map<String, dynamic> newObject = {
      ...data,
      ...newValue,
    };
    print(newObject);
    LocalStorage.write(newObject);
    return LocalStorageState(
      data: newObject
    );
  }

  Future<LocalStorageState> load_() async {
    print('load!!!');
    final Map<String, dynamic> localData = await LocalStorage.read();
    print(localData);
    return LocalStorageState(data: localData);
  }

  LocalStorageState load(Map<String, dynamic> localData) {
    return LocalStorageState(data: localData);
  }

  LocalStorageState copyWith({ Map<String, dynamic>? data }) {
    print(data);
    return LocalStorageState( data: data ?? this.data);
  }

}

class LocalStorageInitial extends LocalStorageState {}
