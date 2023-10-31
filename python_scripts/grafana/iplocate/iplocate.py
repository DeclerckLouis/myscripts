import datetime
import requests
import os
import re

#change location for debugging
# towrite = "/var/www/apache/failedip/failedip.csv"
towrite = "failedip.csv"

with open(towrite, 'a+') as csvfile:
        if os.stat(towrite).st_size == 0:
            print("file is empty")
            csvfile.write("timestamp,ip,trieduser\r\n")
            with open('/var/log/auth.log', 'r') as log:
                #start reading the log file  
                lines = log.readlines()
                iplist = []
                for l in lines:
                    l=l.strip()
                    #check if the line contains the string "invalid user" or "authenticating user" and "[preauth]"
                    if (("from invalid user" in l or "by invalid user" in l or "authenicating user" in l) and "[preauth]" in l):
                        ip_address = re.search(r"([0-9]+(\.[0-9]+)+)", l)
                        ip_address = ip_address.group(0)
                        if "invaliduser user user" in l:
                            trieduser = l.split("user")[2].lstrip().split()[0]  #TOFIX GRRRRRR
                        else:    
                            trieduser = l.split('user')[1].lstrip().split()[0]
                        month = l.split()[0]
                        day = l.split()[1]
                        time = l.split()[2]
                        year = datetime.datetime.now().year
                        logtime = datetime.datetime.strptime(day + " " + month + " " + str(year) + " " + time, "%d %b %Y %H:%M:%S")
                        #logtime -2 hours for UTC time in grafana (idk why)
                        processedtime = logtime - datetime.timedelta(hours=2)
                        if ip_address not in iplist:
                            iplist.append([logtime, ip_address,trieduser])

        else:
            print("file is not empty")
            with open(towrite, 'r') as csvfile:
                lastline = csvfile.readlines()[-1]
                lastdatetime = lastline.split(",")[0]
                try:
                    lastdatetime = datetime.datetime.strptime(lastdatetime, "%Y-%m-%d %H:%M:%S").strftime("%b %d %H:%M:%S") #
                    print(lastdatetime)
                except ValueError as ve:
                    print(ve)
                    print("error parsing last date in towite file; starting from beginning")
                    lastdatetime = None
            with open('/var/log/auth.log', 'r') as log:
                #start reading the log file  
                lines = log.readlines()
                iplist = []
                for l in lines:
                    l=l.strip()
                    if (lastdatetime is None) or (l.startswith(lastdatetime)):
                    #check if the line contains the string "invalid user" or "authenticating user" and "[preauth]"
                        if (("from invalid user" in l or "by invalid user" in l or "authenicating user" in l) and "[preauth]" in l):
                            if "invalid user user" in l:
                                trieduser = l.split("user")[2].lstrip().split()[0]  #TOFIX GRRRRRR
                            else:
                                trieduser = l.split('user')[1].lstrip().split()[0]
                            ip_address = l.split()[-4]
                            month = l.split()[0]
                            day = l.split()[1]
                            time = l.split()[2]
                            year = datetime.datetime.now().year
                            logtime = datetime.datetime.strptime(day + " " + month + " " + str(year) + " " + time, "%d %b %Y %H:%M:%S")
                            processedtime = logtime - datetime.timedelta(hours=2)
                            if ip_address not in iplist:
                                iplist.append([processedtime, ip_address,trieduser])
                        
with open(towrite, 'a+') as csvfile:
    for i in iplist:
        csvfile.write(str(i[0]) + "," + i[1] + "," + i[2] + "\r\n")




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


