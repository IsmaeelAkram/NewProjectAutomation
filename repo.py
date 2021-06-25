from dotenv import load_dotenv
import os
import sys
import ssh

load_dotenv()
ssh = ssh.EasySSH(
    os.getenv("SSH_HOSTNAME"), os.getenv("SSH_USERNAME"), os.getenv("SSH_PASSWORD")
)


def execute(cmd: str, root=False):
    if root:
        print("root: " + cmd)
        print(ssh.execute_as_root(cmd, os.getenv("SSH_PASSWORD"))[1])
    else:
        print(cmd)
        print(ssh.execute(cmd)[1])


def create_repo(repo_name):
    execute(f"mkdir /srv/git/{repo_name}.git")
    execute(f"git init --bare /srv/git/{repo_name}.git")
    # execute(f"mkdir /var/www/html/{repo_name}")
    # execute(f"cd /var/www/html/{repo_name}; stagit /srv/git/{repo_name}.git")


def remove_repo(repo_name):
    execute(f"rm -rf /srv/git/{repo_name}.git")
    # execute(f"rm -rf /var/www/html/{repo_name}")


if "create" in sys.argv[1]:
    create_repo(sys.argv[2])
elif "remove" in sys.argv[1]:
    remove_repo(sys.argv[2])
