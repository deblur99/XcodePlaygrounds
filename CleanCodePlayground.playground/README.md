## adder.sh 사용법

```
$0 <파일 이름>
```

### 사용 예시

현재 파일 구조가 다음과 같을 때:

```
CleanCodePlayground.playground
|- Resources
   |- 01.CleanCode.md
   |- 02.CodeSmells.md
   |- 03.TestCodeInPerspectiveOfCleanCode.md
|- Sources
   |- 01.CleanCode.swift
   |- 02.CodeSmells.swift
   |- 03.TestCodeInPerspectiveOfCleanCode.swift
|- adder.sh
|- ...
```

터미널 실행 후 `cd <{이전 경로}/CleanCodePlayground.playground>` 명령어로 .playground 내부 경로로 이동한다.
이후 adder.sh 스크립트를 새 파일 이름을 매개변수에 포함하여 실행한다.

```sh
sh adder.sh NewContent
```

성공적으로 실행되면

```
파일 생성 완료: Resources/04.NewContent.md, Sources/04.NewContent.swift
```

로 출력되며, 생성된 결과 파일 구조는 다음과 같다.

```
CleanCodePlayground.playground
|- Resources
   |- 01.CleanCode.md
   |- 02.CodeSmells.md
   |- 03.TestCodeInPerspectiveOfCleanCode.md
   |- 04.NewContent.md
|- Sources
   |- 01.CleanCode.swift
   |- 02.CodeSmells.swift
   |- 03.TestCodeInPerspectiveOfCleanCode.swift
   |- 04.NewContent.swift
|- adder.sh
|- ...
```