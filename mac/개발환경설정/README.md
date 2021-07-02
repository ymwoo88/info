# 개발환경
# 맥북 개발환경 설정

## [BREWHOME 사용]

맥OS 자체가 처음이면 Homebrew를 모를거다 나도 몰랐으니까..

맥OS에있는 터미널에서 Homebrew명령어를 이용하여 필요한 것들을 설치 할 수 있다.

(라이센스 문제나 M1칩 특성으로 설치가 안되는 경우가 있는데 구글링해서 진행)

M1칩 Mac에서 Homebrew 설치방법
 - M1실리콘 맥북은 설치 후 바로 동작이 안되서 아래 링크에 나온 가이드를 참고
 - https://designdepot.tistory.com/209  
 - 설치가 필요한게 있는 경우 아래 사이트에서 검색 후 가이드를 참고
 - https://formulae.brew.sh/

## [TIP 사이트]

맥북 커스텀하게 쓸려고 참고했던 사이트 입니다.
- https://subicura.com/2017/11/22/mac-os-development-environment-setup.html
- https://github.com/jojoldu/review/tree/master/%EB%A7%A5%EB%B6%81_%EC%A0%81%EC%9D%91%EA%B8%B0
 
 

## [개발툴 설치]

1. JDK 설치
 - https://formulae.brew.sh/formula/openjdk@8#default
 - 가이드 참고 사이트 
 - https://findstar.pe.kr/2019/01/20/install-openjdk-by-homebrew/  

2. eclipse 이클립스
 - 내부에서 공통으로 사용하고 있는 기준은 없는 듯 하여 sts 공식사이트가서 최신 버전 설치 진행
 - https://spring.io/tools
 
3. intelliJ 인텔리제이
 - 회사 및 개인 라이센스가 없으면 Community버전 사용
 - https://www.jetbrains.com/ko-kr/idea/download/#section=mac

4. DB 공용으로 사용가능한 DBeaver 설치  
 - https://dbeaver.io/download/?start&os=win&arch=x86_64

5. Git tool 
 - 개인적으로 git cmd로 하는거보다는 툴 사용하는 걸 선호한다.
 - 소스트리보다 fork가 빠르고 프리버전도 회사에서 라이센스 제한은 없다고 한다.
 - (fork) https://formulae.brew.sh/cask/fork#default
 
6. Postman  
 - https://formulae.brew.sh/cask/postman#default
