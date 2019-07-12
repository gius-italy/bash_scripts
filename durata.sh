#!/bin/bash
# Calcolata la durata totale dei file audio/video passati come argomento

sum=0
for file in "$@"; do
	val=($(ffprobe -i $file 2>&1 | grep -o -E "[0-9]+:[0-9]+:[0-9]+" | tr ":" " "))
	sum=$(( sum + 10#${val[0]}*60*60 + 10#${val[1]}*60 + 10#${val[1]}))
done



echo -n "Durata totale: "
if [ $sum -le 60 ]; then
	echo $sum"s"
elif [ $sum -le 3600 ]; then
	min=$(( sum/60 )) 
	sec=$(( sum%60 ))
	echo $min"m "$sec"s"
elif [ $sum -gt 3600 ]; then
	hours=$(( sum/60/60 )) 
	min=$(( (sum%3600)/60 ))
	sec=$(( (sum%3600)%60 ))
       echo $hours"h "$min"m "$sec"s"	
fi

