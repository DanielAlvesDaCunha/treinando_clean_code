import 'package:clean_code_project/interactor/entities/project_entity.dart';
import 'package:flutter/material.dart';

final projectState = ValueNotifier<List<ProjectEntity>>([]);
final projectLoadingState = ValueNotifier<bool>(false);
