#!/bin/zsh
rm Generator.txt
rm trackParametersFile.txt
rm histograms/*
rm furtherTests/*
eventCount=10000000
g++ -std=c++11 -o ./fullsystem ../FullSystemV1.cpp
for i in {1..$eventCount}
do
	rm MM_file.txt
	./fullsystem >> MM_file.txt
#	cp MM_file.txt ./furtherTests/MM_file$i.txt
	if [ $i -eq $eventCount ]; then
		python3 visualization.py
	fi
done
