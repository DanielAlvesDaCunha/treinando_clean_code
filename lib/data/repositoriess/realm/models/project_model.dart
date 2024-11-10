import 'package:realm/realm.dart';

part 'project_model.realm.dart';

@RealmModel() 
class _ProjectModel {
  @PrimaryKey()
  late String name;
  late String description;
  late String gitStatus;
  late String path;
}
