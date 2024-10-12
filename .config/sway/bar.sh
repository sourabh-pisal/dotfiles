while true
do
  battery=$(cat /sys/class/power_supply/BAT0/capacity)
  time=$(date +'%A, %b %d %I:%M %p')
  echo "Battery: $battery | Time: $time "
  sleep 30
done 
