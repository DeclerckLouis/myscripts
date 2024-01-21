import os
# interact with os
import re
# do regular expressions
import subprocess
# call other python sripts
import datetime
# TIME

# get output from the speedtest command
response = subprocess.Popen('/usr/bin/speedtest --accept-license --accept-gdpr', shell=True, stdout=subprocess.PIPE).stdout.read().decode('utf-8')

# use regex to split it
ping = re.search('Latency:\s+(.*?)\s', response, re.MULTILINE).group(1)
download = re.search('Download:\s+(.*?)\s', response, re.MULTILINE).group(1)
upload = re.search('Upload:\s+(.*?)\s', response, re.MULTILINE).group(1)
jitter = re.search('Latency:.*?jitter:\s+(.*?)ms', response, re.MULTILINE).group(1)

# Get the values
# ping = ping.group(1)
# download = download.group(1)
# upload = upload.group(1)
# jitter = jitter.group(1)


# write it
try:
    # try to create if doesn't exist, otherwise append
    f = open('/var/www/apache/speedtest/speedtest.csv', 'a+')
    # if it's empty, write the header
    if os.stat('/var/www/apache/speedtest/speedtest.csv').st_size == 0:
            f.write('Datetime,Ping (ms),Jitter (ms),Download (Mbps),Upload (Mbps)\r\n')
    # warning, datetime is UTC, not local (due to issues with grafana) 
    f.write(f"{datetime.datetime.utcnow()},{ping},{jitter},{download},{upload}\r\n")

except Exception as e:
    print(e)

