# encoding: utf-8
# copyright: 2016, you
# license: All rights reserved
# date: 2015-05-26
# description: The Red Hat Enterprise Linux 6 Security Technical Implementation Guide (STIG) is published as a tool to improve the security of Department of Defense (DoD) information systems.  Comments or proposed revisions to this document should be sent via e-mail to the following address: disa.stig_spt@mail.mil.
# impacts

title 'V-38635 - The audit system must be configured to audit all attempts to alter system time through adjtimex.'

control 'V-38635' do
  impact 0.1
  title 'The audit system must be configured to audit all attempts to alter system time through adjtimex.'
  desc '
Arbitrary changes to the system time can be used to obfuscate nefarious activities in log files, as well as to confuse network services that are highly dependent upon an accurate system time (such as sshd). All changes to the system time should be audited.
'
  tag 'stig','V-38635'
  tag severity: 'low'
  tag checkid: 'C-46194r2_chk'
  tag fixid: 'F-43584r2_fix'
  tag version: 'RHEL-06-000165'
  tag ruleid: 'SV-50436r3_rule'
  tag fixtext: '
On a 32-bit system, add the following to "/etc/audit/audit.rules":

# audit_time_rules
-a always,exit -F arch=b32 -S adjtimex -k audit_time_rules

On a 64-bit system, add the following to "/etc/audit/audit.rules":

# audit_time_rules
-a always,exit -F arch=b64 -S adjtimex -k audit_time_rules

The -k option allows for the specification of a key in string form that can be used for better reporting capability through ausearch and aureport. Multiple system calls can be defined on the same line to save space if desired, but is not required. See an example of multiple combined syscalls:

-a always,exit -F arch=b64 -S adjtimex -S settimeofday -S clock_settime -k audit_time_rules
'
  tag checktext: '
To determine if the system is configured to audit calls to the "adjtimex" system call, run the following command:

$ sudo grep -w "adjtimex" /etc/audit/audit.rules

If the system is configured to audit this activity, it will return a line.

If the system is not configured to audit time changes, this is a finding.
'

# START_DESCRIBE
  tag 'auditd','audit.rules','adjtimex','syscall'
  describe auditd_rules.syscall('adjtimex').action do
    it { should eq(['always']) }
  end
# END_DESCRIBE

end