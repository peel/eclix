require 'spec_helper'

pub_name = "test"
pub = Eclix::Publication.new(pub_name)
path = '/home/escenic/pub/'

describe Eclix::Publication do

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

