# Mailbox check script

This script simply reads **gmail accounts** from file send as first argument and sends notification about
unread email count.

## Requirements

- wget
- notification daemon because it uses **notify-send** command

## Usage

Create you accounts file following format like this:

    Mailbox name|Gmail username including @gmail.com|password

Example of two mailbox file **/home/user/.gmail_accounts.dat**:

    Home Mailbox|home@gmail.com|secret
    Work Mailbox|work@company.com|secret

Now running the shell like:

    check_mailbox.sh /home/user/.gmail_accounts.dat

Would send a desktop notification about unread emails. Comfortable when you do not want to be
annoyed every minute by popups and just want to check your mail when you want to by binding this
script to a specific key sequence.
