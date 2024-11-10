import 'dart:io';

import 'package:clean_code_project/data/repositoriess/realm/models/project_model.dart';
import 'package:clean_code_project/interactor/entities/project_entity.dart';
import 'package:clean_code_project/interactor/repositories/project_repositories.dart';
import 'package:realm/realm.dart';

Realm initializeRealm() {
  var config = Configuration.local([ProjectModel.schema]);
  var realm = Realm(config);
  return realm;
}

class RealmProjectRepositories implements ProjectRepositories {
  final Realm realm;

  RealmProjectRepositories({required this.realm});
  @override
  Future<List<ProjectEntity>> getProjects() async {
    var projects = realm.all<ProjectModel>(); 
    return projects
            .map((e) => ProjectEntity(
      directory: Directory(e.path),
      name: e.name,
      description: e.description,
      gitStatus: e.gitStatus,))
            .toList();
  }
  

  
  @override
  Future<ProjectEntity> putProject(ProjectEntity project) {
    // TODO: implement putProject
    throw UnimplementedError();
  }
  
  @override
  Future<ProjectEntity> deleteProject(ProjectEntity project) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }
}

