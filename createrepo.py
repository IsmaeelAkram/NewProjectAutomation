from dotenv import load_dotenv

load_dotenv()
import os
import ssh

ssh = ssh.EasySSH(
    os.getenv("SSH_HOSTNAME"), os.getenv("SSH_USERNAME"), os.getenv("SSH_PASSWORD")
)
print(ssh.execute("whoami"))
