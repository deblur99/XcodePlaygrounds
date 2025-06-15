#!/bin/bash

# 생성할 파일 이름을 받음
FILE_NAME="$1"

if [ -z "$FILE_NAME" ]; then
  echo "사용법: $0 <파일 이름>"
  exit 1
fi

# Resources 디렉토리 생성 (없을 경우)
mkdir -p "Playgrounds/Resources"
mkdir -p "Playgrounds/Sources"
# 가장 높은 번호를 찾고 +1
max_number=0
for dir in "Playgrounds/Resources" "Playgrounds/Sources"; do
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

new_number=$(printf "%02d" "$((10#$max_number + 1))")

# 새 파일 생성
touch "Playgrounds/Resources/$new_number.$FILE_NAME.md"
touch "Playgrounds/Sources/$new_number.$FILE_NAME.swift"

echo "파일 생성 완료: Playgrounds/Resources/$new_number.$FILE_NAME.md, Playgrounds/Sources/$new_number.$FILE_NAME.swift"