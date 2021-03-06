# encoding: utf-8
# copyright: 2016, you
# license: All rights reserved
# date: 2015-05-26
# description: The Red Hat Enterprise Linux 6 Security Technical Implementation Guide (STIG) is published as a tool to improve the security of Department of Defense (DoD) information systems.  Comments or proposed revisions to this document should be sent via e-mail to the following address: disa.stig_spt@mail.mil.
# impacts

title 'V-38547 - The audit system must be configured to audit all discretionary access control permission modifications using fchmod.'

control 'V-38547' do
  impact 0.1
  title 'The audit system must be configured to audit all discretionary access control permission modifications using fchmod.'
  desc '
The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users.
'
  tag 'stig','V-38547'
  tag severity: 'low'
  tag checkid: 'C-46105r2_chk'
  tag fixid: 'F-43495r2_fix'
  tag version: 'RHEL-06-000186'
  tag ruleid: 'SV-50348r3_rule'
  tag fixtext: '
At a minimum, the audit system should collect file permission changes for all users and root. Add the following to "/etc/audit/audit.rules":

-a always,exit -F arch=b32 -S fchmod -F auid>=500 -F auid!=4294967295 \
-k perm_mod
-a always,exit -F arch=b32 -S fchmod -F auid=0 -k perm_mod

If the system is 64-bit, then also add the following:

-a always,exit -F arch=b64 -S fchmod -F auid>=500 -F auid!=4294967295 \
-k perm_mod
-a always,exit -F arch=b64 -S fchmod -F auid=0 -k perm_mod
'
  tag checktext: '
To determine if the system is configured to audit calls to the "fchmod" system call, run the following command:

$ sudo grep -w "fchmod" /etc/audit/audit.rules

If the system is configured to audit this activity, it will return several lines.

If no line is returned, this is a finding.
'

# START_DESCRIBE
  describe auditd_rules.syscall('fchmod').action do
    it { should eq(['always']) }
  end
# END_DESCRIBE

end
