# 이사대학 Flutter 과제

### 주요 기능
- 회원 목록 조회
- 회원 상세 보기 및 수정
- 회원 추가 및 삭제
- 무한 스크롤 기능
- Firestore 연동 및 데이터 관리

### 사용된 기술
- **Flutter**        : UI 개발
- **Riverpod**       : 상태 관리
- **Cloud Firestore**: 데이터 저장 및 관리

### Packages used
```
- dependencies:
    - flutter_riverpod: ^2.3.0
    - cloud_firestore: ^4.8.0
    - firebase_core: ^3.8.1
    - intl: ^0.20.1
- dev_dependencies:
    - mocktail: ^1.0.4
    - mockito: ^5.3.2
    - firebase_core: ^3.8.1
    - fake_cloud_firestore: ^3.1.0

```

### folder structure
```
lib
┣ core
┃ ┣ di
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

### 스크린샷
| 회원 목록 화면 | 회원 추가 화면 | 회원 상세 화면 |
|:--------:|:--------:|:--------:|
| 회원 목록 화면 | 회원 추가 화면 | 회원 상세 화면 |


## 설치 및 실행 방법

### 1. Flutter 설치
Flutter를 설치하고 `flutter doctor`를 통해 환경을 확인하세요. 
[Flutter 설치 가이드](https://docs.flutter.dev/get-started/install)

### 2. 프로젝트 클론
```bash
git clone https://github.com/dohy-9443/move_university_subject.git
cd project-name
```

### 3. 종속성 설치
```bash
flutter pub get
```
