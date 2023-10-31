# A python script that tests internet speed and writes results to a csv

## Requirements

- A good mood
- active internet connection
- a computer
- a brain
- **Pyhton** (tested using 3.9)

## Dependencies

- speedtest
can be installed using the following commands:
```bash
sudo apt install apt-transport-https gnupg1 dirmngr lsb-release
curl -L https://packagecloud.io/ookla/speedtest-cli/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/speedtestcli-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/speedtestcli-archive-keyring.gpg] https://packagecloud.io/ookla/speedtest-cli/debian/ $(lsb_release -cs) main" | sudo tee  /etc/apt/sources.list.d/speedtest.list
sudo apt update
sudo apt install speedtest
```

## Tested using

- Python 3.9
- A raspberry pi 4 running Raspbian GNU/Linux 11 (bullseye) armv7l


## Author Information

Louis Declerck 2SNWB B
 - [GitHub](https://github.com/DeclerckLouis)
 - [LinkedIn](https://www.linkedin.com/in/louis-declerck-student)
 - [louis.declerck@student.howest.be](mailto:louis.declerck@student.howest.be)

## Contributing

Any and all feedback / imporvements are welcome. They can be submitted via issues or pull requests.
or just send me a message on [LinkedIn](https://www.linkedin.com/in/louis-declerck-student) or [GitHub](https://www.github.com/DeclerckLouis) :)

## Acknowledgements

- myself, for making this script and being awesome
- [speedtest.net](https://www.speedtest.net) for making the speedtest