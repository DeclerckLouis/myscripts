from shodan import Shodan
from tabulate import tabulate
import cred


api = Shodan(cred.shodan_key)

# # Lookup an IP
# ipinfo = api.host('8.8.8.8')
# print(ipinfo)

# # Search for websites that have been "hacked"
# for banner in api.search_cursor('http.title:"hacked by"'):
#     print(banner)


# # Get the total number of industrial control systems services on the Internet
# ics_services = api.count('tag:ics')
# print(f"Industrial Control Systems: {ics_services['total']}")

out = api.dns.domain_info(domain="howest.be")
subdomainslist = out["data"]
to_tabulate = []
for sub in subdomainslist:
    try:
        type = sub["type"]
        host = sub["value"]
        open_ports = sub["ports"]
    except KeyError:
        type = sub["type"]
        host = sub["value"]
        open_ports = "None"
    to_tabulate.append([type, host, open_ports])

print(tabulate(to_tabulate, headers=["Type", "Host", "Open ports"]))
