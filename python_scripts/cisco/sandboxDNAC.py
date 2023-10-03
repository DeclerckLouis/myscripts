# Hello there!

import testcred as credentials

import requests
from requests.auth import HTTPBasicAuth
import json
from tabulate import tabulate



device_data_list = []  # data from one device
devices_list = []  # all devices' info listed together
devices_dict_by_hostname = {}  # to choose a device based on hostname
devices_dict_by_ip = {}  # to choose a device based on ip


def get_auth_json(username=credentials.testusername, password=credentials.testpassword):
    url = 'https://sandboxdnac.cisco.com/dna/system/api/v1/auth/token'
    resp = requests.request("POST", url, auth=HTTPBasicAuth(username, password), verify=False)
    if resp.status_code != 200:
        print(f"Sorry, there has been a mistake with the authentication process \nStatus code: {resp.status_code}\nMessage: {resp.text}")
    return resp.json()


def get_auth_token(jsondata):
    token = jsondata['Token']
    # print(f"\n\nToken Retrieved: {token}\n\n")
    return token


def get_devices_list(token):
    url = "https://sandboxdnac.cisco.com/api/v1/network-device"
    headers = {"x-auth-token": token, "content-type": "application/json"}
    resp = requests.request("GET", url, headers=headers, verify=False)
    return resp.json()


def get_interfaces_device(token, id):
    url = "https://sandboxdnac.cisco.com/api/v1/interface"
    headers = {"x-auth-token": token, "content-type": "application/json"}
    parameters = {"id": id}
    resp = requests.request("GET", url, headers=headers,
                            params=parameters, verify=False)
    return resp.json()


def get_device_configuration(token, id):
    url = f"https://sandboxdnac.cisco.com/api/v1/network-device/{id}/config"
    headers = {"x-auth-token": token, "content-type": "application/json"}
    resp = requests.request("GET", url, headers=headers, verify=False)
    return resp.json()

#Gebruikersnaam en wachtwoord opvragen, indien geen opgegeven wordt de standaard meegegeven
username = input("Geef uw gebruikersnaam op (laat leeg voor test): ")
if username.rstrip(" ") == "":
    username = credentials.testusername
password = input("Geef uw wachtwoord op (laat leeg voor test): ")
if password.rstrip(" ") == "":
    password = credentials.testpassword


# Token Opvragen
auth_jsondata = get_auth_json(username, password)

auth_token = get_auth_token(auth_jsondata)
devices_list_json = get_devices_list(auth_token)

# print(json.dumps(devices_list_json["response"], indent=4))


for device in devices_list_json["response"]:
    # put all info in variables
    device_type = device["type"]
    device_hostname = device["hostname"]
    device_management_ip = device["managementIpAddress"]
    device_macaddress = device["macAddress"]
    device_id = device["id"]

    # save the variables in a list PER device
    device_data_list = device_type, device_hostname, device_management_ip, device_macaddress

    # save the devices infolists in a list
    devices_list.append(device_data_list)

    # save in a dict to use for search purposes later
    # voor id gekozen i.p.v mac-address omdat gebruikers met de juiste tools mac-adressen kunnen spoofen
    # Het id wordt gegeven door devnet zelf volgens mij en is daardoor ook moeilijker te vervalsen
    devices_dict_by_hostname[device_hostname] = device_id
    devices_dict_by_ip[device_management_ip] = device_id
# print(devices_dict_by_hostname)


# Pretty print all of it in a nice overview
print(f"\n"*100)
print("OVERVIEW:")
print(tabulate(devices_list, headers=["Type", "Hostname", "IP-addr", "MAC-addr"]))
print(f"\n")

valid_device_id = False
while valid_device_id == False:
    #vraag welke device te selecteren
    picked_device = input("Geef de hostname of het IP-adres op van het device waar u meer info over wilt: ")
    #Check of device in één van de twee dicts zit
    if picked_device in devices_dict_by_hostname.keys() or picked_device in devices_dict_by_ip.keys():
        print("Device has been found in the database.")
        valid_device_id = True
        valid_choice = False
        while valid_choice == False:
            #vraag wat men wilt zien
            config_or_interfaces = input(
                "Wilt u de Config of de Interfaces laten zien? (C/I): ")
            #device id intellen op id uit de dict
            if picked_device in devices_dict_by_ip.keys():
                device_id = devices_dict_by_ip[picked_device]
            elif picked_device in devices_dict_by_hostname.keys():
                device_id = devices_dict_by_hostname[picked_device]
            else:
                device_id = False
                print("There has been an unkown error. This shouldn't be possible.")
                break
            print(f"Device id (For debugging purposes): {device_id}")

            #Indien men C typte:
            if config_or_interfaces.rstrip(" ").lower() == "c":
                #valid op true zodat de code stopt
                valid_choice = True

                #Get config bestand van device
                config_data_json = get_device_configuration(auth_token, device_id)

                #Wegschrijven naar bestand met hostname als naam
                device_hostname = [k for k, v in devices_dict_by_hostname.items() if v == device_id][0]
                print(device_hostname)
                config = str(config_data_json["response"])
                with open(f"{device_hostname}.CiscoConfig", "w+") as fo:
                    fo.writelines(config)
                print(f'Config is opgeslagen in het bestand "{device_hostname}.CiscoConfig" voor uw gemak.')
            
            #Indien men I typte
            elif config_or_interfaces.rstrip(" ").lower() == "i":
                # valid op True zodat de loop stopt
                valid_choice = True
                # lijsten hier pas gedeclareerd voor efficientie
                interface_data_list = []  # Data van één interface in een lijst
                interfaces_list_all = []  # Lijst van alle interfaces
                interfaces_list_up = []  # lijst van alle actieve interfaces

                #Get alle interfaces van het device
                device_interfaces_list_json = get_interfaces_device(auth_token, device_id)
                #vragen of men alle interfaces wilt zien, of enkel de actieve + loop om input te controleren
                alloractive = False
                while alloractive == False:
                    whatinterfaces = input('Wilt u alle interfaces zien (A) of enkel de interfaces die "UP" zijn? (U) ')
                    if whatinterfaces.rstrip(" ").lower() == "a" or whatinterfaces.rstrip(" ").lower() == "u":
                        alloractive = True
                        #Alle data in aparte variabelen steken per interface
                        for interface in device_interfaces_list_json["response"]:
                            portname = interface["portName"]
                            vlanid = interface["vlanId"]
                            portmode = interface["portMode"]
                            porttype = interface["portType"]
                            duplex = interface["duplex"]
                            status = interface["status"]
                            lastupdated = interface["lastUpdated"]
                            ipaddress = interface["ipv4Address"]
                            netmask = interface["ipv4Mask"]

                            # alle variabelen in een lijst per interface
                            interface_all_data_list = portname, vlanid, portmode, porttype, duplex, status, lastupdated, "|", ipaddress, netmask

                            #Alle niet-actieve interfaces als een lege string opslaan, samen met alle actieve interfaces, dit om later de lege strings eruit te halen
                            if interface["status"] == "up":
                                interface_up_data_list = portname, vlanid, portmode, porttype, duplex, status, lastupdated, "|", ipaddress, netmask
                            else:
                                # we moeten dit hier zetten, anders possibly unbound error
                                interface_up_data_list = ""
                            # voeg interface toen aan lijst om later te pretty-printen
                            interfaces_list_all.append(interface_all_data_list)
                            interfaces_list_up.append(interface_up_data_list)
                            # deze while loop verwijdert alle lege strings in de lijst.
                            while "" in interfaces_list_up:
                                interfaces_list_up.remove("")

                        else:
                            print("Invalid input, please try again.")
                    #indien het antwoord "a" was, alle interfaces tonen
                    if whatinterfaces.rstrip(" ").lower() == "a":
                        print(tabulate(interfaces_list_all, headers=[
                            "Port Name", "VLAN ID", "Port Mode", "Port Type", "Duplex", "Status", "Last updated", "|", "IPv4 Address", "Netmask"]))

                    #indien het u was, enkel de actieve tonen
                    elif whatinterfaces.rstrip(" ").lower() == "u":
                        print(tabulate(interfaces_list_up, headers=[
                            "Port Name", "VLAN ID", "Port Mode", "Port Type", "Duplex", "Status", "Last updated", "|", "IPv4 Address", "Netmask"]))

                #print(f"{json.dumps(device_interfaces_list_json, indent=4)}")
            else:
                print("Invalid input. Be honest, how did you manage to mess this up? Anyways try again.")

    else:
        print("Could not find anything with given input, please try again.")

#General Kenobi