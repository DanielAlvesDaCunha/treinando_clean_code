// ignore_for_file: unused_local_variable

import 'package:clean_code_project/interactor/injector/injector.dart';
import 'package:clean_code_project/interactor/entities/project_entity.dart';
import 'package:clean_code_project/interactor/repositories/project_repositories.dart';
import 'package:clean_code_project/interactor/services/Launcher_service.dart';
import 'package:clean_code_project/interactor/services/git_service.dart';
import 'package:clean_code_project/interactor/states/project_states.dart';

Future<void> fetchAllProject() async {
  projectLoadingState.value = true;
  final repository = injector.get<ProjectRepositories>();
  final projects = await repository.getProjects();
  projectState.value = projects;

  projectLoadingState.value = false;
}

Future<void> putProject(ProjectEntity project) async {
  final repository = injector.get<ProjectRepositories>();
  final updatedProject = await repository.putProject(project);
  final projects = projectState.value.toList();
  final index = projects
      .indexWhere((p) => p.directory.path == updatedProject.directory.path);
  if (index != -1) {
    projects[index] = updatedProject;
  } else {
    projects.add(updatedProject);
  }
  projectState.value = projects;
}

Future<void> deleteProject(ProjectEntity project) async {
  final repository = injector.get<ProjectRepositories>();
  final deletedProject = await repository.deleteProject(project);
  final projects = projectState.value.toList();
  projects.removeWhere((p) => p.directory.path == deletedProject.directory.path);
  projectState.value = projects;  

}

Future<void> updateProjectGitStatus(ProjectEntity project) async {
  final repository = injector.get<GitService>();
  final status = await repository.getStatus(project.directory);
  final updatedProject = project.copyWith(gitStatus: status);
  await putProject(updatedProject);

}

void openProject(ProjectEntity project)  {
  final repository = injector.get<LauncherService>();
  repository.launch(project.directory);
}
