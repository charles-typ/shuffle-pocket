stagger_duration=20
export num_tasks=200
export write_element_size=1024
export process_time=1
export total_time=20

echo python pywren_write_pocket.py $num_tasks $i $write_element_size $process_time $total_time 1
python pywren_write_pocket.py $num_tasks $i $write_element_size $process_time $total_time 1 &
for i in {2..5}; do
    echo python pywren_write_pocket.py $num_tasks $i $write_element_size $process_time $total_time 0 
    python pywren_write_pocket.py $num_tasks $i $write_element_size $process_time $total_time 0 &
    sleep $stagger_duration
done
wait
