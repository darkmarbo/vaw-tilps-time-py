#!/bin/sh -x

wav_dir=$1
wav_out=$2
lab_dir=lab

if(($# < 3))
then
	echo "usage $0 wav_dir wav_out"
	echo "同名的txt文本放到lab目录中 "
	exit 0
fi

ls -1 $wav_dir|while read line
do
	echo "line is $line"
	name=${line%.wav}
	txt="${name}.txt"
	cat $lab_dir/$txt|while read time
	do
		echo "time is $time"
		time_tmp=`echo $time|sed 's/\t/ /g'`
		time_tmp=${time_tmp# *}
		time_tmp=${time_tmp%* }
		st=${time_tmp% *}
		ed=${time_tmp#* }
		#echo "st:${st}ed:$ed"
		#echo "python split.py $wav_dir/$line $wav_out/${name}_${st}_${ed}.wav $st $ed"
		python split.py $wav_dir/$line $wav_out/${name}_${st}_${ed}.wav $st $ed
	done
done
