Log Parser
===============
*Log Parser* is a Ruby command-line application that parses CEF event log messages in a local text file and prints to the console information about each event in the following format:

```sh
{
 'source_ip': source IP address,
 'destination_ip': destination IP address,
 'source_ip_valid: True/False,
 'destination_ip_valid': True/False,
 'source_ip_is_private': True/False,
 'destination_ip_is_private': True/False
}
```

Getting Started
===============

A text file containing sample event logs is provided at the top level of this project in `​logs.txt`​

To get started, please run:

`​ruby bin/log_parser logs.txt`

Requirements
============

Please ensure the following gems are installed:

`​gem ‘ipaddress’`

`gem ‘json'`
