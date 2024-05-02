#!/bin/bash

if [ ! -f "report.txt" ]; then
    echo "Error: report.txt not found."
    exit 1
fi

#html report

cat << EOF > /var/www/html/report.html
<!DOCKTYPE html>
<html>
<head>
<title>
Access logs with IOC indicators:
</title>
<style>
table {
  border-collapse: collapse;
  width: 90%
}
th, td {
  border: 1px solid black;
  padding: 6px;
  text-align: left;
}
th {
  background-color: f1f1f1;
}
</style>
</head>
<body>

<h2>
Access logs with IOC indicators :)
</h2>

<table>
  <tr>
 </tr>
EOF
while IFS= read -r line; do
    ip=$(echo "$line" | awk '{print $2}')
    datetime=$(echo "$line" | awk '{print $NF}')
    echo "<tr><td>$ip</td><td>$datetime</td><td>$page_accessed</td></tr>" >> /var/www/html/report.html
done < report.txt
cat << EOF >> /var/www/html/report.html
</table>
</body>
</html>
EOF
echo "HTML report generated and saved to /var/www/html/report.html"
