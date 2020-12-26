stagger_duration=20
export num_tasks=200
export write_element_size=1024
export process_time=1
export total_time=20
export directory_server=10.10.10.1

for i in {1..5}; do
    echo python pywren_write_jiffy.py $num_tasks $i $write_element_size $process_time $total_time $directory_server 
    python pywren_write_jiffy.py $num_tasks $i $write_element_size $process_time $total_time $directory_server &
    sleep $stagger_duration
done
wait
