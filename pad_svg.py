import os

path = 'd:/wazuh images/modified/300x70px.svg'
target_size = 1024 * 1024  # 1MB

if os.path.exists(path):
    current_size = os.path.getsize(path)
    if current_size < target_size:
        padding_needed = target_size - current_size
        # Append XML comment padding
        padding = '<!-- ' + 'A' * (padding_needed - 10) + ' -->'
        with open(path, 'a') as f:
            f.write(padding)
        print(f"Increased file size to {os.path.getsize(path)} bytes")
    else:
        print(f"File is already large enough: {current_size} bytes")
else:
    print("File not found")
