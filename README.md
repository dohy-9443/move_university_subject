# 이사대학 Flutter 과제

## Packages used
```
- dependencies:
    - flutter_riverpod: ^2.3.0
    - cloud_firestore: ^4.8.0
    - firebase_core: ^3.8.1

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
### 각 폴더별 역할
1. **core**         : 프로젝트 전체에서 사용하는 공통 코드
2. **data**         : 외부 데이터 소스와 관련된 구현 코드(ex. firebase)
3. **domain**       : entity, repository interface, use case 등 비지니스 로직
4. **presentation** : view 와 view model UI 와 상태관리 코드 