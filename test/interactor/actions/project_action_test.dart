import 'dart:io';

import 'package:clean_code_project/interactor/injector/injector.dart';
import 'package:clean_code_project/interactor/actions/project_action.dart';
import 'package:clean_code_project/interactor/entities/project_entity.dart';
import 'package:clean_code_project/interactor/repositories/project_repositories.dart';
import 'package:clean_code_project/interactor/services/git_service.dart';
import 'package:clean_code_project/interactor/states/project_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ProjectRepositoryMock extends Mock implements ProjectRepositories {
  @override
  Future<List<ProjectEntity>> getProjects() async {
    return [
      ProjectEntity(
          name: 'project 1',
          directory: Directory('path 1'),
          description: '',
          gitStatus: ''),
    ];
  }

  @override
  Future<ProjectEntity> putProject(ProjectEntity project) {
    return Future.value(project);
  }

  @override
  Future<ProjectEntity> deleteProject(ProjectEntity project) {
    return Future.value(project);
  }
}

class GitServiceMock extends Mock implements GitService {
  @override
  Future<String> getStatus(Directory path) {
    return Future.value('updated');
  }
}

  void main() {
    group('putProject', () {
      test('Deve colocar atualizar um projeto', () async {
        injector.replaceInstance<ProjectRepositories>(ProjectRepositoryMock());
        await fetchAllProject();
        expect(projectState.value.length, 1);
        final project =
            projectState.value.first.copyWith(description: 'Changed');
        await putProject(project);
        expect(project.description, 'Changed');
      });

      test('Deve colocar um projeto', () async {
        injector.replaceInstance<ProjectRepositories>(ProjectRepositoryMock());
        projectState.value = [];

        final project = ProjectEntity(
            name: 'project 1',
            directory: Directory('path 1'),
            description: '',
            gitStatus: '');

        expect(projectState.value.length, 0);
        await putProject(project);
        expect(projectState.value.length, 1);
      });
    });
    group('fetchAllProject', () {
      injector.replaceInstance<ProjectRepositories>(ProjectRepositoryMock());
      test('Deve pegar lista de Projetos', () async {
        await fetchAllProject();
        expect(projectState.value.length, 1);
      });
    });

    group('deleteProject', () {
      injector.replaceInstance<ProjectRepositories>(ProjectRepositoryMock());
      test('deve apagar uma lista de projetos', () async {
        await fetchAllProject();
        expect(projectState.value.length, 1);
        final project = projectState.value.first;
        await deleteProject(project);
        expect(projectState.value.length, 0);
      });
    });

    group('updateProjectGitStatus', () {
      test('deve atualizar uma lista de projetos', () async {
        injector.replaceInstance<GitService>(GitServiceMock());
        await fetchAllProject();
        expect(projectState.value.length, 1);
        final project = projectState.value.first;
        await updateProjectGitStatus(project);
        expect(projectState.value.length, 1);
        expect(projectState.value.first.gitStatus, 'updated');
      });
    });
  }
