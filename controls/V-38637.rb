# encoding: utf-8
# copyright: 2016, you
# license: All rights reserved
# date: 2015-05-26
# description: The Red Hat Enterprise Linux 6 Security Technical Implementation Guide (STIG) is published as a tool to improve the security of Department of Defense (DoD) information systems.  Comments or proposed revisions to this document should be sent via e-mail to the following address: disa.stig_spt@mail.mil.
# impacts

title 'V-38637 - The system package management tool must verify contents of all files associated with the audit package.'

control 'V-38637' do
  impact 0.5
  title 'The system package management tool must verify contents of all files associated with the audit package.'
  desc '
The hash on important files like audit system executables should match the information given by the RPM database. Audit executables  with erroneous hashes could be a sign of nefarious activity on the system.
'
  tag 'stig','V-38637'
  tag severity: 'medium'
  tag checkid: 'C-46196r3_chk'
  tag fixid: 'F-43586r1_fix'
  tag version: 'RHEL-06-000281'
  tag ruleid: 'SV-50438r2_rule'
  tag fixtext: '
The RPM package management system can check the hashes of audit system package files. Run the following command to list which audit files on the system have hashes that differ from what is expected by the RPM database:

# rpm -V audit | grep \'^..5\'

A "c" in the second column indicates that a file is a configuration file, which may appropriately be expected to change. If the file that has changed was not expected to then refresh from distribution media or online repositories.

rpm -Uvh [affected_package]

OR

yum reinstall [affected_package]
'
  tag checktext: '
The following command will list which audit files on the system have file hashes different from what is expected by the RPM database.

# rpm -V audit | awk \'$1 ~ /..5/ && $2 != "c"\'


If there is output, this is a finding.
'

# START_DESCRIBE
  tag 'auditd','rpm','checksum'
  if os[:family] == 'redhat'
    describe command("rpm -V audit | grep '^..5'") do
      its('stdout') { should eq "" }
    end
  elsif os[:family] == 'debian'
    # UBUNTU
  end
# END_DESCRIBE

end
