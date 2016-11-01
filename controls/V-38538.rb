# encoding: utf-8
# copyright: 2016, you
# license: All rights reserved
# date: 2015-05-26
# description: The Red Hat Enterprise Linux 6 Security Technical Implementation Guide (STIG) is published as a tool to improve the security of Department of Defense (DoD) information systems.  Comments or proposed revisions to this document should be sent via e-mail to the following address: disa.stig_spt@mail.mil.
# impacts

title 'V-38538 - The operating system must automatically audit account termination.'

control 'V-38538' do
  impact 0.1
  title 'The operating system must automatically audit account termination.'
  desc '
In addition to auditing new user and group accounts, these watches will alert the system administrator(s) to any modifications. Any unexpected users, groups, or modifications should be investigated for legitimacy.
'
  tag 'stig','V-38538'
  tag severity: 'low'
  tag checkid: 'C-46096r1_chk'
  tag fixid: 'F-43486r1_fix'
  tag version: 'RHEL-06-000177'
  tag ruleid: 'SV-50339r1_rule'
  tag fixtext: '
Add the following to "/etc/audit/audit.rules", in order to capture events that modify account changes:

# audit_account_changes
-w /etc/group -p wa -k audit_account_changes
-w /etc/passwd -p wa -k audit_account_changes
-w /etc/gshadow -p wa -k audit_account_changes
-w /etc/shadow -p wa -k audit_account_changes
-w /etc/security/opasswd -p wa -k audit_account_changes
'
  tag checktext: '
To determine if the system is configured to audit account changes, run the following command:

auditctl -l | egrep \'(/etc/passwd|/etc/shadow|/etc/group|/etc/gshadow|/etc/security/opasswd)\'

If the system is configured to watch for account changes, lines should be returned for each file specified (and with "perm=wa" for each).
If the system is not configured to audit account changes, this is a finding.
'

# START_DESCRIBE
  ['/etc/group','/etc/passwd','/etc/gshadow','/etc/shadow','/etc/security/opasswd'].each do |file|
    describe auditd_rules do
      its('lines') { should include("-w #{file} -p wa -k audit_account_changes") }
    end
  end
# END_DESCRIBE

end
