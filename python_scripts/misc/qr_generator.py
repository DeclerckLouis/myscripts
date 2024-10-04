# A script that generates a QR code for a given URL
# note: this script file cannot be named "qrcode.py" as it will cause an error

import qrcode

def generate_qr_code(url):
    qr = qrcode.make(url)
    qr.save("qrcode.png")

if __name__ == "__main__":
    try:
        url = input("Enter the URL: ")
        generate_qr_code(url)
    except KeyboardInterrupt:
        print(f"\n User interrupted.")
    except Exception as e:
        print(f"An error occurred: {e}")