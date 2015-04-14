require 'spec_helper'

describe Eclix::Url do

  describe '#base' do
    it 'returns a base url (http://{host}:{port}) for a given url' do
      expect(Eclix::Url.new(Eclix::Server.new,'abc').base).to eq('http://localhost:8080')
    end
  end

  describe '#absolute' do
    it 'returns an absolute url for a given url path' do
      expect(Eclix::Url.new(Eclix::Server.new,'abc').absolute).to eq('http://localhost:8080/abc')
    end
  end
end

describe Eclix::Escenic do

  describe '#admin_url' do
    it 'returns absolute escenic admin url' do
      expect(Eclix::Escenic.new.admin_url.absolute).to eq('http://localhost:8080/escenic-admin')
    end
  end

  describe '#resource_url' do
    it 'returns absolute escenic resource submission url' do
      expect(Eclix::Escenic.new.resource_url.absolute).to eq('http://localhost:8080/escenic-admin/do/publication/resource')
    end
  end

  describe '#publish_url' do
    it 'returns absolute escenic publication submission url' do
      expect(Eclix::Escenic.new.publish_url.absolute).to eq('http://localhost:8080/escenic-admin/do/publication/insert')
    end
  end
end
