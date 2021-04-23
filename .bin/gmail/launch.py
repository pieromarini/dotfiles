#!/usr/bin/env python3

import os
import argparse
import subprocess
import json
from pathlib import Path
from googleapiclient import discovery, errors
from google.oauth2.credentials import Credentials
from httplib2 import ServerNotFoundError


parser = argparse.ArgumentParser()
parser.add_argument('-l', '--label', default='INBOX')
parser.add_argument('-p', '--prefix', default='\uf0e0')
args = parser.parse_args()

DIR = Path(__file__).resolve().parent
PREV_COUNT_DIR = '/tmp/mail_count'
CREDENTIALS_PATH = Path(DIR, 'credentials.json')

error_prefix = '%{F' + "#ff0000" + '}\uf06a %{F-}'

prev_read = []


def format_count(count, color, is_odd=False):
    output = ''
    if count > 0:
        output = '%{F' + color + '}' + args.prefix + ' %{F-} ' + str(count) + ' '
    else:
        output = ''
    return output


def get_unread_email(count_was, creds, label, color):
    cred = Credentials.from_authorized_user_info(creds)
    gmail = discovery.build('gmail', 'v1', credentials=cred)

    labels = gmail.users().labels().get(userId='me', id=label).execute()
    count = labels['messagesUnread']
    formatted_output = format_count(count, color)

    return count, formatted_output


def save_count(counts):
    data = ",".join([str(i) for i in counts])
    with open(PREV_COUNT_DIR, 'w+') as f:
        try:
            f.write(data)
            f.close()
        except:
            f.close()


try:
    n_accounts = 0
    output = ''
    if Path(CREDENTIALS_PATH).is_file():
        with open(CREDENTIALS_PATH, 'r') as f:
            credentials = json.load(f)
        f.close()
        n_accounts = credentials["count"]
    else:
        print(error_prefix + 'credentials not found', flush=True)

    if Path(PREV_COUNT_DIR).is_file():
        with open(PREV_COUNT_DIR, 'r+') as t:
            prev_read = [int(x) for x in t.read().split(",")]
        t.close()
        if len(prev_read) < n_accounts:
            for i in range(0, n_accounts- len(prev_read)):
                prev_read.append(0)
    else:
        prev_read = [0] * n_accounts

    # NOTE: label handling
    labels = args.label.split(",")

    if len(labels) < n_accounts:
        for i in range(0, n_accounts - len(labels)):
            labels.append("INBOX")

    if len(labels) > n_accounts:
        labels = labels[0:n_accounts]

    for i in range(0, n_accounts):
        credential = credentials["creds"][i]
        prev_read[i], formatted_output = get_unread_email(prev_read[i], credential["cred"], labels[i], credential["color"])
        output += formatted_output

    print(output)
    save_count(prev_read)

except errors.HttpError as error:
    if error.resp.status == 404:
        print(error_prefix + 'Probably, one of the labels was not found', flush=True)
    else:
        print('There was an Http Error')
except (ServerNotFoundError, OSError):
    print('Server not found')
except Exception(e):
    print(e)
