module Eclix
  class Publication
    attr_reader :name, :publisher, :password, :context
    def initialize(name,publisher='Escenic',password='admin',context=name)
      @name = name
      @publisher=publisher
      @password=password
      @context=context
      @context||=name
    end
    def template(path)
      path+"template"
    end
    def static(path)
      path+"static"
    end
  end
end
