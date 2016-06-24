#
# Cookbook Name:: myhaproxy
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#node.default['haproxy']['members'] = [{
# 'hostname'=> 'ec2-54-197-178-190.compute-1.amazonaws.com',
# 'ipaddress'=> '54.197.178.190',
# 'port'=> 80,
# 'ssl_port'=> 80
#},
#{
# 'hostname'=> 'ec2-54-167-149-49.compute-1.amazonaws.com',
# 'ipaddress'=> '54.167.149.49',
# 'port'=> 80,
# 'ssl_port'=> 80
#}]


all_web_nodes = search('node','role:web')

members = []

all_web_nodes.each do |web_node|
  
  member = { 
      'hostname'=> web_node['cloud']['public_hostname'],
      'ipaddress'=> web_node['cloud']['public_ipv4'],
      'port'=> 80,
      'ssl_port'=> 80
  }
  members.push(member)
end

node.default['haproxy']['members'] = members

include_recipe 'haproxy::default'

