#!/bin/zsh
for i in {1..100}
do
	g++ -o test ../FullSystemV1.cpp
	./test
	python3 ../visualization.py
done
