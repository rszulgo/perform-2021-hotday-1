# Log event ingest via HTTP interface (curl)
1. Plain text ingest
```Shell
curl -X POST --data "Log content" https://<env-URL>/api/v2/logs/ingest
     -H "Content-Type:text/plain; charset=utf-8" --header "Authorization:Api-Token ******"
```
2. JSON ingest
```Shell
curl -X POST "https://<env-URL>/api/v2/logs/ingest" -H "accept: */*" -H "Authorization: Api-Token ***"
     -H "Content-Type: application/json; charset=utf-8" --data "{\"content\":\"JSON log content\"}"
```

# FluentD operations
1. Start fluentD and check status
```Shell
sudo systemctl start td-agent.service
sudo systemctl start td-agent.service
```
2. Check fluentD logs
```Shell
sudo tail -fn 100 /var/log/td-agent/td-agent.log
```
3. Review fluentD configuration file
```Shell
sudo vim /etc/td-agent/td-agent.conf
```
4. Push log events over HTTP input plugin (default configuration)
```Shell
curl -X POST -d 'json={"json":"message"}' http://localhost:8888/debug.test
```

# Active Gate operations
1. Start & stop Active Gate
```Shell
service dynatracegateway stop
service dynatracegateway start
```

2. Edit Active Gate custom.properties
```Shell
vi /var/lib/dynatrace/gateway/config/custom.properties​
```

