#!/bin/bash

# 생성할 파일 이름을 받음
FILE_NAME="$1"

if [ -z "$FILE_NAME" ]; then
  echo "사용법: $0 <파일 이름>"
  exit 1
fi

# Resources 디렉토리 생성 (없을 경우)
mkdir -p "Resources"
mkdir -p "Sources"
# 가장 높은 번호를 찾고 +1
max_number=0
for dir in "Resources" "Sources"; do
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
touch "Resources/$new_number.$FILE_NAME.md"
touch "Sources/$new_number.$FILE_NAME.swift"

echo "파일 생성 완료: Resources/$new_number.$FILE_NAME.md, Sources/$new_number.$FILE_NAME.swift"
