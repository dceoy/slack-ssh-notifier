slack_ssh_login_notifier
========================

Slack notifier for SSH login

Usage
-----

1.  Check out the repository.

    ```sh
    $ git clone https://github.com/dceoy/slack_ssh_login_notifier.git
    $ cd slack_ssh_login_notifier
    ```

2.  Set `slack_env.sh`.

    ```sh
    $ cp example_slack_env.sh slack_env.sh
    $ vi slack_env.sh # => set environment variables for slack notification
    ```

3.  Test notification.

    ```sh
    $ ./notify.sh
    ```

4.  Set `/etc/ssh/sshrc`.

    ```sh
    $ sudo bash -c "echo 'bash $(pwd)/notify.sh' >> /etc/ssh/sshrc"
    ```
