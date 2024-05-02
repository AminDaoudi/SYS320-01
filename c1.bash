curl -s http://10.0.17.18/IOC.html > IOC.html

grep -oP '(?<=<td>).*?(?=</td)' IOC.html | awk 'NR % 2 == 1' > IOC.txt

rm IOC.html

echo "IOC patterns extracted and saved to IOC.txt"
