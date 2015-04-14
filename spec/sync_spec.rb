require 'spec_helper'

pub_name = "test"
path = '/home/escenic/pub/'

describe Eclix::Remote do
  server_name = "test"
  host = "host"
  port = 22
  user = "user"
  pass = "pass"
  credentials = Eclix::Credentials.new(user,pass)
  remote = Eclix::Remote.new(server_name, host, port, credentials)

  describe '#publication_dir' do
    it 'creates a publication absolute dir on remote server' do
      expect(remote.publication_dir(pub_name)).to eq "/opt/tomcat-#{server_name}/webapps-#{pub_name}/#{pub_name}/"
    end
  end

  describe '#user' do
    it 'returns ussername on remote server' do
      expect(remote.user).to eq user
    end
  end

  describe '#password' do
    it 'returns ussername on remote server' do
      expect(remote.password).to eq pass
    end
  end
end

describe Eclix::Local do
  local = Eclix::Local.new(path)
  describe '#publication_dir' do
    it 'creates a publication absolute dir on remote server' do
      expect(local.publication_dir(pub_name)).to eq "#{path}/publications/#{pub_name}/src/main/webapp/"
    end
  end
end

#TODO: Add tests for upload
