#!/bin/python3
import requests

headers = {"Cookie": ""} # Add your cookie here


def main():
    counter = 1
    while True:
        resp = requests.get(f"https://leho-howest.instructure.com/courses/{counter}", headers=headers)
        if resp.status_code == 200:
            print(f'\033[1;32m[HIT]\033[0m - {counter} --> {resp.status_code}')
            writeToFile(counter)
        else:
            print(f'\033[1;31m[NO HIT]\033[0m - {counter} --> {resp.status_code}')
        counter += 1


def writeToFile(endpoint):
    with open("results", "a") as f:
        f.write(f"https://leho-howest.instructure.com/courses/{endpoint}\n")


if __name__ == "__main__":
    main()