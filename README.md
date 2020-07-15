Log Parser
===============
*Log Parser* is a Ruby command-line application that parses CEF event log messages in a local text file. Information about each event is printed to the console and saved to a local text file, `output.txt` in the following format:

```sh
{
 'source_ip': 'source IP address',
 'destination_ip': 'destination IP address',
 'source_ip_valid: boolean,
 'destination_ip_valid': boolean,
 'source_ip_is_private': boolean,
 'destination_ip_is_private': boolean
}
```

Getting Started
===============

A text file containing sample event logs is provided at the top-level of this project in `​logs.txt`​

To get started, please run:

`​ruby bin/log_parser logs.txt`

The output will be saved in a text file at the top-level of this project.

Requirements
============

Please ensure the following gems are installed:

```sh
gem ‘ipaddress’
gem ‘json'
```
