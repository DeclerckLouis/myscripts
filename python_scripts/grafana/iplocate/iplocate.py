import datetime
import requests
import os
import re

#check if the save file exists, if not, create it and write the header
# towrite = "/var/www/apache/failedip/failedip.csv"
towrite = "failedip.csv"

with open(towrite, 'a+') as csvfile:
        if os.stat(towrite).st_size == 0:
            print("file is empty")
            csvfile.write("timestamp,ip\r\n")
            with open('/var/log/auth.log', 'r') as log:
                #start reading the log file  
                lines = log.readlines()
                iplist = []
                for l in lines:
                    l=l.strip()
                    #check if the line contains the string "invalid user" or "authenticating user" and "[preauth]"
                    if (("from invalid user" in l or "by invalid user" in l or "authenicating user" in l) and "[preauth]" in l):
                        ip_address = re.search(r"([0-9]+(\.[0-9]+)+)", l)
                        try:
                            ip_address = ip_address.group(0)
                        except AttributeError as ae:
                            print(ae)
                            print(f"error was on line: {l}")
                            continue
                        month = l.split()[0]
                        day = l.split()[1]
                        time = l.split()[2]
                        year = datetime.datetime.now().year
                        logtime = datetime.datetime.strptime(day + " " + month + " " + str(year) + " " + time, "%d %b %Y %H:%M:%S")
                        if ip_address not in iplist:
                            iplist.append([logtime, ip_address])

        else:
            print("file is not empty")
            with open(towrite, 'r') as csvfile:
                last_line = csvfile.readlines()[-1]
                lastlog = last_line.split(",")[0]
                print(lastlog)
            with open('/var/log/auth.log', 'r') as log:
                #start reading the log file  
                lines = log.readlines()
                iplist = []
                for l in lines:
                    l=l.strip()
                    if l.startswith(lastlog):
                        print("found last log")
                    #check if the line contains the string "invalid user" or "authenticating user" and "[preauth]"
                        if (("from invalid user" in l or "by invalid user" in l or "authenicating user" in l) and "[preauth]" in l):
                            ip_address = l.split()[-4]
                            month = l.split()[0]
                            day = l.split()[1]
                            time = l.split()[2]
                            year = datetime.datetime.now().year
                            logtime = datetime.datetime.strptime(day + " " + month + " " + str(year) + " " + time, "%d %b %Y %H:%M:%S")
                            if ip_address not in iplist:
                                iplist.append([logtime, ip_address])
                        
with open(towrite, 'a+') as csvfile:
    for i in iplist:
        csvfile.write(str(i[0]) + "," + i[1] + "\r\n")




# with open('/var/log/auth.log', 'r') as log:
#     #start reading the log file  
#     lines = log.readlines()
#     iplist = []
#     for l in lines:
#         l=l.strip()
#         if l.startswith(lastlog):
#             print("found last log")
#             #check if the line contains the string "invalid user" or "authenticating user" and "[preauth]"
#             if ("invalid user" in l or "authenicating user" in l) and "[preauth]" in l:
#                 ip_address = l.split()[-4]
#                 month = l.split()[0]
#                 day = l.split()[1]
#                 time = l.split()[2]
#                 year = datetime.datetime.now().year
#                 logtime = datetime.datetime.strptime(day + " " + month + " " + str(year) + " " + time, "%d %b %Y %H:%M:%S")
#                 if ip_address not in iplist:
#                     iplist.append([logtime, ip_address])


