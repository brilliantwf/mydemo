import re
import boto3
import os
import socket

domainname = os.environ['DNSNAME']
aclname = os.environ['ACLNAME']


def lambda_handler(event, context):

    # Get the current IP addresses
    dns_record = domainname
    ip_addresses = socket.getaddrinfo(dns_record, None)
    current_ips = list(set([ip[4][0] for ip in ip_addresses]))

    print(current_ips)

    # Update the ACL rule to allow traffic from the new IP addresses
    ec2 = boto3.client('ec2')
    for index, current_ip in enumerate(current_ips):
        entry = {
            'CidrBlock': current_ip + '/32',
            'Egress': True,
            'Protocol': '-1',
            'NetworkAclId': aclname,
            'RuleAction': 'deny',
            'RuleNumber': 99 - index
        }
        ec2.create_network_acl_entry(**entry)

    return 'ACL rule updated'
