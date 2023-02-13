# to install RSAT tools on a remote computer, create an ansible playbook with the following content:

# - name: install RSAT tools
#   win_powershell:
#     script: Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability –Online
#   delegate_to:
#     -
#   become: yes
#   become_method: runas
#   become_user: Administrator
#   become_password: password
#   register: rsat
#   ignore_errors: yes
#   tags:
#     - rsat
#

#the command to installl RSAT tools on a computer is:
Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability –Online
