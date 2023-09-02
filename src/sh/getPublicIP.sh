echo $(curl -s ipinfo.io | grep "\"ip\"" | sed -n 's/.*"ip": "\(.*\)".*/\1/p')
