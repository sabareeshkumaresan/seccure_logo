import base64
import os
from PIL import Image
import io

path = 'd:/wazuh images/modified/'
png_path = os.path.join(path, '300x70px.png')
svg_path = os.path.join(path, '300x70px.svg')
target_size = 1024 * 1024  # 1MB

# Open the original image
img = Image.open(png_path)

# Resize/Compress until it fits
quality = 90
width, height = img.size
scale = 1.0

while True:
    # Resize
    new_width = int(width * scale)
    new_height = int(height * scale)
    resized_img = img.resize((new_width, new_height), Image.Resampling.LANCZOS)
    
    # Save to buffer
    buffer = io.BytesIO()
    resized_img.save(buffer, format="PNG", optimize=True)
    img_data = base64.b64encode(buffer.getvalue()).decode('utf-8')
    
    # Create SVG content
    svg_content = f'''<svg width="300" height="70" viewBox="0 0 300 70" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <image href="data:image/png;base64,{img_data}" width="300" height="70" preserveAspectRatio="xMidYMid meet" />
</svg>'''
    
    # Check size
    if len(svg_content) < target_size:
        with open(svg_path, 'w') as f:
            f.write(svg_content)
        print(f"Success! SVG size: {len(svg_content)} bytes. Image scale: {scale:.2f}")
        break
    
    # Reduce scale if too big
    scale -= 0.1
    if scale < 0.1:
        print("Error: Could not compress enough.")
        break
