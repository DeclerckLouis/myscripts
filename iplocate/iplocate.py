import requests
import tabulate 

def get_failed_ip():
    log = open('/var/log/auth.log', 'r')
    loglines = log.readlines()
    iplist = []
    for line in loglines:
        line = line.strip()
        if "Connection closed" in line and "[preauth]" in line:
            port = line.split()[-2]
            ip_address = line.split()[-4]
            if ip_address not in iplist:
                iplist.append(ip_address)
        elif "Connection closed" in line and "[preauth]" not in line and "error" not in line:
            # port = line.split()[-1]
            ip_address = line.split()[-3]
            if ip_address not in iplist:
                iplist.append(ip_address)
    return iplist

def get_location(ip_address):
    response = requests.get(f'https://ipapi.co/{ip_address}/json/').json()
    location_data = {
        "ip": ip_address,
        "city": response.get("city"),
        "region": response.get("region"),
        "country": response.get("country_name")
        "hostname": response.get("hostname")
        "org": response.get("org")
    }
    return location_data


locationlist = []
failed_iplist = get_failed_ip()
for ip in failed_iplist:
    iplocation = get_location(ip)
    locationlist.append(iplocation)

print(tabulate.tabulate(locationlist, headers="keys"))

# for i in list:
#     if i["country"] == "United States":
#         print(i)
        

