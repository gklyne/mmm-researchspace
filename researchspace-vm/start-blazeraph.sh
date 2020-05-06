java -server -Xmx4g -jar /root/blazegraph-2.1.5.jar &

sleep 3s
echo ""
echo "****"
echo ""
echo "Use this IP address in 'http://<IP-address>:9999./blazegraph/' to access Blazegraph:"
echo ""
ifconfig eth1

