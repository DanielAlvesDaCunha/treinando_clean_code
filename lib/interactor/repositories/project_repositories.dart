import 'package:clean_code_project/interactor/entities/project_entity.dart';

abstract class ProjectRepositories {
  Future<List<ProjectEntity>> getProjects();

  Future<ProjectEntity> putProject(ProjectEntity project);

  Future<ProjectEntity> deleteProject(ProjectEntity project);

}
