# Copy www files

remote_directory node['deploy_to'] do
  source 'www'
  recursive true
end

# Configure Nginx #

include_recipe 'nginx'

file "#{node[:nginx][:dir]}/sites-enabled/default" do
  action :delete
end

template "#{node[:nginx][:dir]}/sites-enabled/#{node['id']}" do
  source "nginx.conf.erb"
  variables :node => node
  notifies :restart, resources(:service => "nginx")
end
