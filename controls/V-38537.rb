# encoding: utf-8
# copyright: 2016, you
# license: All rights reserved
# date: 2015-05-26
# description: The Red Hat Enterprise Linux 6 Security Technical Implementation Guide (STIG) is published as a tool to improve the security of Department of Defense (DoD) information systems.  Comments or proposed revisions to this document should be sent via e-mail to the following address: disa.stig_spt@mail.mil.
# impacts

title 'V-38537 - The system must ignore ICMPv4 bogus error responses.'

control 'V-38537' do
  impact 0.1
  title 'The system must ignore ICMPv4 bogus error responses.'
  desc '
Ignoring bogus ICMP error responses reduces log size, although some activity would not be logged.
'
  tag 'stig','V-38537'
  tag severity: 'low'
  tag checkid: 'C-46095r2_chk'
  tag fixid: 'F-43485r1_fix'
  tag version: 'RHEL-06-000093'
  tag ruleid: 'SV-50338r2_rule'
  tag fixtext: '
To set the runtime status of the "net.ipv4.icmp_ignore_bogus_error_responses" kernel parameter, run the following command:

# sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1

If this is not the system\'s default value, add the following line to "/etc/sysctl.conf":

net.ipv4.icmp_ignore_bogus_error_responses = 1
'
  tag checktext: '
The status of the "net.ipv4.icmp_ignore_bogus_error_responses" kernel parameter can be queried by running the following command:

$ sysctl net.ipv4.icmp_ignore_bogus_error_responses

The output of the command should indicate a value of "1". If this value is not the default value, investigate how it could have been adjusted at runtime, and verify it is not set improperly in "/etc/sysctl.conf".

$ grep net.ipv4.icmp_ignore_bogus_error_responses /etc/sysctl.conf

If the correct value is not returned, this is a finding.
'

# START_DESCRIBE
  describe kernel_parameter('net.ipv4.icmp_ignore_bogus_error_responses') do
    its('value') { should eq 1 }
  end
# END_DESCRIBE

end
