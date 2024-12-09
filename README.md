# 이사대학 Flutter 과제

## Packages used
```
- dependencies:
    - flutter_riverpod: ^2.3.0
    - freezed_annotation: ^2.4.4
    - json_annotation: ^4.9.0
    - cloud_firestore: ^4.8.0

- dev_dependencies:
    - build_runner: ^2.4.12
    - freezed: ^2.5.7
    - json_serializable: ^6.8.0
```

## folder structure
```
lib
┣ core
┃ ┣ exception
┃ ┣ use_case
┃ ┗ util
┃ 
┣ data
┃ ┣ data_sources
┃ ┃ ┗ remote
┃ ┣ model
┃ ┗ repository
┃ 
┣ domain
┃ ┣ entity
┃ ┣ repository
┃ ┣ use_case
┃ 
┣ presentation
┃ ┣ view
┃ ┃ ┣ screen
┃ ┃ ┗ widget
┃ ┣ view_model
┃ 
┣ app.dart
┗ main.dart
```