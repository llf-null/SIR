#!/bin/bash
total_round=10

rm -rf checkpoint_log
rm -rf ft_event_logs
rm -rf bp_event_logs

make

for((i=0; i < $total_round; i++))
do
	echo start_round_$i
	bash train.sh $i
	python -u ForwardTraining.py $i 0 10 
	python -u BackwardEmbedding.py $i $total_round 0 5
	#python -u ForwardTraining.py $i 0 1
	#python -u BackwardEmbedding.py $i $total_round 0 1
done

bash train.sh $total_round
python -u ForwardTraining.py $total_round 0 10
echo finished running the program!
