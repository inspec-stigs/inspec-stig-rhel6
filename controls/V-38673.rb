# encoding: utf-8
# copyright: 2016, you
# license: All rights reserved
# date: 2015-05-26
# description: The Red Hat Enterprise Linux 6 Security Technical Implementation Guide (STIG) is published as a tool to improve the security of Department of Defense (DoD) information systems.  Comments or proposed revisions to this document should be sent via e-mail to the following address: disa.stig_spt@mail.mil.
# impacts

title 'V-38673 - The operating system must ensure unauthorized, security-relevant configuration changes detected are tracked.'

control 'V-38673' do
  impact 0.5
  title 'The operating system must ensure unauthorized, security-relevant configuration changes detected are tracked.'
  desc '
By default, AIDE does not install itself for periodic execution. Periodically running AIDE may reveal unexpected changes in installed files.
'
  tag 'stig','V-38673'
  tag severity: 'medium'
  tag checkid: 'C-46232r2_chk'
  tag fixid: 'F-43621r1_fix'
  tag version: 'RHEL-06-000307'
  tag ruleid: 'SV-50474r2_rule'
  tag fixtext: '
AIDE should be executed on a periodic basis to check for changes. To implement a daily execution of AIDE at 4:05am using cron, add the following line to /etc/crontab:

05 4 * * * root /usr/sbin/aide --check

AIDE can be executed periodically through other means; this is merely one example.
'
  tag checktext: '
To determine that periodic AIDE execution has been scheduled, run the following command:

# grep aide /etc/crontab /etc/cron.*/*

If there is no output, this is a finding.
'

# START_DESCRIBE
  tag 'aide','cron'
  describe command('grep aide /etc/crontab /etc/cron.*/*') do
    its('stdout') { should_not eq "" }
  end
# END_DESCRIBE

end
