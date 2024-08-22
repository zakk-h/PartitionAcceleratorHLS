find . -type f -size +75M | while read FILE; do
  echo "$FILE" >> .gitignore
done