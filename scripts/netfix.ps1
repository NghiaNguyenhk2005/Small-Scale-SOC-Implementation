# Xóa cấu hình cũ
netsh interface portproxy reset

# Forward port SSH từ Windows vào WSL2
netsh interface portproxy add v4tov4 listenport=22 listenaddress=0.0.0.0 connectport=22 connectaddress=[IP_CỦA_WSL2]

# Mở firewall cho phép truy cập SSH
netsh advfirewall firewall add rule name="Allow SSH" dir=in action=allow protocol=TCP localport=22
