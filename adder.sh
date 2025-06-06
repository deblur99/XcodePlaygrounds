#!/bin/bash

# 스크립트가 실행된 파일 경로를 받음
PLAYGROUND_PATH="$1"

# 생성할 파일 이름
FILE_NAME="$2"

if [ -z "$PLAYGROUND_PATH" ] || [ -z "$FILE_NAME" ]; then
  echo "사용법: $0 <플레이그라운드 경로> <파일 이름>"
  exit 1
fi

# 플레이그라운드 경로를 이용하여 새 파일을 생성하는 기능
if [ -d "$PLAYGROUND_PATH" ]; then

  # Resources 디렉토리 생성 (없을 경우)
  mkdir -p "$PLAYGROUND_PATH/Resources"
  mkdir -p "$PLAYGROUND_PATH/Sources"

  # 가장 높은 번호를 찾고 +1
  max_number=0

  for dir in "$PLAYGROUND_PATH/Resources" "$PLAYGROUND_PATH/Sources"; do
    if [ -d "$dir" ]; then
      for file in "$dir"/*; do
        base_file=$(basename "$file")
        if [[ "$base_file" =~ ^([0-9]+)\..* ]]; then
          num=${BASH_REMATCH[1]}
          if [ "$num" -gt "$max_number" ]; then
            max_number=$num
          fi
        fi
      done
    fi
  done

  new_number=$(printf "%02d" $((max_number + 1)))

  # 새 파일 생성
  touch "$PLAYGROUND_PATH/Resources/$new_number.$FILE_NAME.md"
  touch "$PLAYGROUND_PATH/Sources/$new_number.$FILE_NAME.swift"

  echo "파일 생성 완료: $PLAYGROUND_PATH/Resources/$new_number.$FILE_NAME.md, $PLAYGROUND_PATH/Sources/$new_number.$FILE_NAME.swift"

else
  echo "오류: 플레이그라운드 경로 '$PLAYGROUND_PATH'가 존재하지 않습니다."
fi