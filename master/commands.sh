g++ -o ./fullsystem ./FullSystemV1.cpp
rm MM_file.txt
rm MM_file1.txt
rm MM_file2.txt
rm MM_file_temporary.txt
./fullsystem >> MM_file_temporary.txt
tail -n 56 MM_file_temporary.txt >> MM_file2.txt
head -n 13 MM_file_temporary.txt >> MM_file1.txt
cat MM_file1.txt MM_file_space.txt MM_file2.txt >> MM_file.txt
python3 visualization.py
