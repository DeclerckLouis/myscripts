import qrcode
import svgwrite

def generate_qr_code_svg(url):
    # Generate QR code matrix
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=10,
        border=4,
    )
    qr.add_data(url)
    qr.make(fit=True)
    qr_matrix = qr.modules
    
    # Create an SVG drawing
    dwg = svgwrite.Drawing(size=(len(qr_matrix) * 10, len(qr_matrix) * 10), profile='tiny')
    
    # Draw the QR code
    for row in range(len(qr_matrix)):
        for col in range(len(qr_matrix[row])):
            if qr_matrix[row][col]:
                dwg.add(dwg.rect(insert=(col * 10, row * 10), size=(10, 10), fill='black'))
    
    # Save the SVG to a string
    return dwg.tostring()

if __name__ == "__main__":
    try:
        url = input("Enter the URL: ")
        svg_content = generate_qr_code_svg(url)
        with open("qrcode.svg", "w") as f:
            f.write(svg_content)
        print("QR code generated and saved as qrcode.svg")
    except KeyboardInterrupt:
        print("\nOperation cancelled by user.")
    except Exception as e:
        print(f"An error occurred: {e}")