stagger_duration=20
export num_tasks=200
export write_element_size=1024
export process_time=1
export total_time=20
export redisnode='ec2-35-155-218-253.us-west-2.compute.amazonaws.com;ec2-18-236-211-3.us-west-2.compute.amazonaws.com;ec2-54-149-81-192.us-west-2.compute.amazonaws.com;ec2-54-189-45-4.us-west-2.compute.amazonaws.com;ec2-35-155-221-97.us-west-2.compute.amazonaws.com'
export bucketName=redis_write

echo python pywren-write-redis.py $num_tasks 1 $write_element_size $process_time 100 $redisnode 
python pywren-write-redis.py $num_tasks 1 $write_element_size $process_time 100 $redisnode &
sleep $stagger_duration

echo python pywren-write-s3.py $num_tasks 2 $write_element_size $process_time 80 $bucketname 
python pywren-write-s3.py $num_tasks 2 $write_element_size $process_time 80 $bucketname &
sleep $stagger_duration

echo python pywren-write-s3.py $num_tasks 3 $write_element_size $process_time 60 $bucketname 
python pywren-write-s3.py $num_tasks 3 $write_element_size $process_time 60 $bucketname &
sleep $stagger_duration

echo python pywren-write-s3.py $num_tasks 4 $write_element_size $process_time 40 $bucketname 
python pywren-write-s3.py $num_tasks 4 $write_element_size $process_time 40 $bucketname &
sleep $stagger_duration

echo python pywren-write-s3.py $num_tasks 5 $write_element_size $process_time 20 $bucketname 
python pywren-write-s3.py $num_tasks 5 $write_element_size $process_time 20 $bucketname &
sleep $stagger_duration
wait
