stagger_duration=${1:-"35"}
for i in {1..5}; do
  bash shuffle_50g.sh staggered_$i &
  sleep $stagger_duration
done
wait
