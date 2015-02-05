require 'rest-client'

  class Publication_Creator
    attr_reader :escenic

    def initialize(escenic=default_env)
      @escenic = escenic
    end

    def new_publication(resources, publication)
      if publication_exists(publication)
        puts "Publication already exists, proceeding..."
      else
        @cookies = get_session_id
        puts "Uploading resources..."
        deploy_resources(resources, @cookies)
        puts "Adding publication config..."
        create_publication(publication, @cookies)
        puts "Done."
      end
    end

    def get_session_id
      response = RestClient.get(escenic.admin_url.absolute)
      response.cookies
    end

    def deploy_resources(resources, cookies)
      RestClient.post(escenic.resource_url.absolute,
                      {
                          :type => resources.type,
                          :resourceFile => File.new(resources.file, 'rb'),
                          :multipart => true
                      },
                      {:cookies => cookies},
      ) { |response, request, result|
        case response.code
          when 200
            response
          else
            raise ResourceUploadException
        end
      }
    end

    def create_publication(publication, cookies)
      RestClient.post(escenic.publish_url.absolute,
                      {
                          :name => publication.name,
                          :publisherName => publication.publisher,
                          :allowEmptyPassword => false,
                          :adminPassword => publication.password,
                          :adminPasswordConfirm => publication.password
                      },
                      {
                          :cookies => cookies
                      }
      ) { |response, request, result|
        case response.code
          when 200
            response
          else
            raise PublicationDefinitionException
        end
      }
    end

    def publication_exists(publication)
      url = escenic.publication_url(publication).absolute
      RestClient.get(url) { |response, request, result|
        case response.code
          when 200
            true
          else
            false
        end
      }
    end

    def default_env
      Escenic.new(Server.new)
    end
  end
  class ResourceUploadException < Exception
  end
  class PublicationDefinitionException < Exception
  end
  class Url
    attr_reader :path, :base
    def initialize(server, path)
      @server=server
      @path=path
      @base=base_url(server)
    end

    def absolute
      "#{base}/#{path}"
    end

    def base_url(server)
      "http://#{server.host}:#{server.port}"
    end
  end
  class Server
    attr_reader :host, :port
    def initialize(port=8080, host='localhost')
      @host=host
      @port=port
    end
  end
  class Escenic
    attr_reader :server
    def initialize(server=Server.new)
      @server=server
    end
    def resource_url
      Url.new(server, 'escenic-admin/do/publication/resource')
    end

    def publish_url
      Url.new(server, 'escenic-admin/do/publication/insert')
    end

    def admin_url
      Url.new(server, 'escenic-admin')
    end

    def publication_url(publication)
      Url.new(server, "#{publication.context}/")
    end
  end
  class Resources
    attr_reader :type, :file
    def initialize(type='webapp', file)
      @type=type
      @file=file
    end
  end
  class Publication
    attr_reader :name, :publisher, :password, :context
    def initialize(name, publisher='Escenic', password='admin', context=name)
      @name=name
      @publisher=publisher
      @password=password
      @context=context
    end
  end
