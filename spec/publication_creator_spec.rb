require 'spec_helper'
require 'publication_creator'

describe Url do
  describe '#base' do
    it '' do
      expect(Url.new(Server.new,'abc').base).to eq('http://localhost:8080')
    end
  end
  describe '#absolute' do
    it '' do
      expect(Url.new(Server.new,'abc').absolute).to eq('http://localhost:8080/abc')
    end
  end
end
describe Escenic do
  describe '#admin_url' do
    it 'should print a valid resource form submission address' do
      expect(Escenic.new.admin_url.absolute).to eq('http://localhost:8080/escenic-admin')
    end
  end
  describe '#resource_url' do
    it 'should print a valid resource form submission address' do
      expect(Escenic.new.resource_url.absolute).to eq('http://localhost:8080/escenic-admin/do/publication/resource')
    end
  end
  describe '#publish_url' do
    it 'should print a valid resource form submission address' do
      expect(Escenic.new.publish_url.absolute).to eq('http://localhost:8080/escenic-admin/do/publication/insert')
    end
  end
  describe '#publish_url' do
    it 'should print a valid resource form submission address' do
      expect(Escenic.new.publication_url(Publication.new('demo')).absolute).to eq('http://localhost:8080/demo/')
    end
  end
end
