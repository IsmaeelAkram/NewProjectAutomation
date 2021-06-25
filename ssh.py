import paramiko
from getpass import getpass


class EasySSH:
    def __init__(self, hostname, username, password, timeout=10, private_key=None):
        """Establish connection to the <hostname> and store the SSHClient"""
        self.SSHClient = paramiko.SSHClient()
        self.SSHClient.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        self.SSHClient.connect(
            hostname,
            username=username,
            password=password,
            timeout=timeout,
            pkey=private_key,
        )

    def execute(self, command):
        """Execute the <command> via the SSHClient and return ( exit_code, outputOfTheCommand )"""
        stdin, stdout, stderr = self.SSHClient.exec_command(command)
        output = "".join(stdout.readlines())
        error_output = "".join(stderr.readlines())
        return (stdout.channel.recv_exit_status(), output, error_output)

    def execute_as_root(self, command, password):
        """Execute the <command> via the SSHClient as a root user on the host and return (exit_code, <output of the command>)"""
        stdin, stdout, stderr = self.SSHClient.exec_command(
            "sudo -S -u root %s" % (command)
        )
        if not stdout.channel.closed:
            stdin.write("%s\n" % (password))
            stdin.flush()
        return (
            stdout.channel.recv_exit_status(),
            "".join(stdout.readlines()),
            "".join(stderr.readlines()),
        )
