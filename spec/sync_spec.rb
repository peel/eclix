require 'spec_helper'
require 'eclix/sync'

#setup
pub_name = "test"
pub = Eclix::Publication.new(pub_name)
path = '/home/escenic/pub/'

describe Publication do
  describe '#template' do
    it "creates a path to templates" do
        expect(pub.template(path)).to eq "#{path}template"
    end
  end
  describe '#static' do
    it "creates a path to static directory" do
        expect(pub.static(path)).to eq "#{path}static"
    end
  end
end


describe Remote do
  server_name = "test"
  host = "host"
  port = 22
  user = "user"
  pass = "pass"
  credentials = Credentials.new(user,pass)
  remote = Remote.new(server_name, host, port, credentials)

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

describe Local do
  local = Local.new(path)
  describe '#publication_dir' do
    it 'creates a publication absolute dir on remote server' do
      expect(local.publication_dir(pub_name)).to eq "#{path}/publications/#{pub_name}/src/main/webapp/"
    end
  end
end

#TODO: Add tests for upload
