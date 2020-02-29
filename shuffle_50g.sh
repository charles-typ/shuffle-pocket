duration=${1:-"35"}
export num_input=200
export num_partition=200

echo python sort-generate.py $num_input
python sort-generate.py $num_input

for i in {1..5}; do
    echo python pywren-part-pocket.py $num_input 1 $num_partition 1  $num_input $i
    python pywren-part-redis.py $num_input 1 $num_partition 1 $num_input $i
    echo python pywren-sort-pocket.py $num_partition 1 $num_input $num_input $i
    python pywren-sort-redis.py $num_partition 1 $num_input $num_input $i
    sleep $duration
done
wait
