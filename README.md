# 이사대학 Flutter 과제

### 주요 기능
- 회원 목록 조회
- 회원 상세 보기 및 수정
- 회원 추가 및 삭제
- 무한 스크롤 기능
- Firestore 연동 및 데이터 관리

### 주요 기능 세부 설명
- 회원 목록 조회: Firestore에 저장된 회원 정보를 무한 스크롤로 가져옵니다.
- 회원 추가: Dialog를 통해 이름, 이메일, 주소를 입력받아 Firestore에 저장합니다.
- 회원 삭제: 스와이프 또는 상세 화면에서 삭제할 수 있습니다.
- 회원 수정: 상세 화면에서 정보를 수정하고 Firestore에 실시간 반영됩니다.


### 사용된 기술
- **Flutter**        : UI 개발
- **Riverpod**       : 상태 관리
- **Cloud Firestore**: 데이터 저장 및 관리

### Packages used
```
- flutter_riverpod: ^2.3.0
- cloud_firestore: ^4.8.0
- firebase_core: ^3.8.1
- intl: ^0.20.1
- flutter_dotenv: ^5.2.1
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

### 앱 디자인
- 테마: 다크 모드 및 라이트 모드를 지원하며, 디바이스의 시스템 설정을 따라갑니다.
- 주요 색상:
  - 라이트 모드: 배경색 #FFFFFF, 주요 색상 #4A90E2
  - 다크 모드: 배경색 #121212, 주요 색상 #1D3557
- 아이콘: Material Design 아이콘 사용

### 스크린샷
| 회원 목록 화면 | 회원 추가 화면 |                                                   회원 상세 화면                                                    |                                                    회원 삭제 화면                                                    |
|:--------:|:--------:|:-------------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------:|
| ![IMG_1985](https://github.com/user-attachments/assets/f7e149c4-d252-41af-995c-5db450860e2d) | ![IMG_1986](https://github.com/user-attachments/assets/28a67426-1ded-4fae-94de-a458771617b9) | ![IMG_1987](https://github.com/user-attachments/assets/c323ec42-0e86-44b7-8e08-060fb1367d06) | ![delete](https://github.com/user-attachments/assets/2f6a021b-bffb-4609-837c-2ff814093d98) |
| ![Screenshot_20241213-172145](https://github.com/user-attachments/assets/869d9422-e126-49e6-a69f-01ea465b379b) | ![Screenshot_20241213-172157](https://github.com/user-attachments/assets/ec8c9a23-3c32-49c5-9deb-0605414819a5) |![Screenshot_20241213-172207](https://github.com/user-attachments/assets/a5aab481-1b66-4ea3-b517-2b6803423dc3) |![Screenshot_20241213-172220](https://github.com/user-attachments/assets/998d798a-998c-4655-b9d6-20e76027003b) |


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

### 4. .env 파일 생성
- key, id 등 양식에 맞게 작성


### 5. 실행
- xcode 에서 simulator 또는 android studio 우측 device manager 에서 emulator 실행
- terminal 에서
  - debug mode 실행
    ```bash
    
    flutter run
    ```
  - release mode 실행
    ```bash
    
    flutter run --release
    ```
