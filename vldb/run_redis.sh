stagger_duration=20
export num_tasks=200
export write_element_size=1024
export process_time=1
export total_time=20
export redisnode=10.10.10.1;10.10.10.2
export bucketName=redis_write

echo python pywren_write_redis.py $num_tasks $1 $write_element_size $process_time $total_time $redisnode 
python pywren_write_redis.py $num_tasks $1 $write_element_size $process_time $total_time $redisnode &

for i in {2..5}; do
    echo python pywren_write_s3.py $num_tasks $i $write_element_size $process_time $total_time $bucketName 
    python pywren_write_s3.py $num_tasks $i $write_element_size $process_time $total_time $bucketName &
    sleep $stagger_duration
done
wait
