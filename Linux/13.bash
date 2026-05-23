#!/bin/bash
SERVICE_NAME="mypythonapp"
PYTHON_SCRIPT_PATH="/usr/local/bin/mypythonapp.py"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

cat << 'EOF' > "$PYTHON_SCRIPT_PATH"
#!/usr/bin/env python3
import time
while True:
    print("Service is running...")
    time.sleep(10)
EOF
chmod +x "$PYTHON_SCRIPT_PATH"

cat << EOF > "$SERVICE_FILE"
[Unit]
Description=Simple Python Service
After=network.target

[Service]
ExecStart=/usr/bin/env python3 $PYTHON_SCRIPT_PATH
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
echo "Service ${SERVICE_NAME} successfully created."
echo "Use 'systemctl start ${SERVICE_NAME}' to execute it."
