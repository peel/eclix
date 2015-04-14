require 'net/scp'

class Credentials
  attr_reader :user, :password
  def initialize(user, password)
    @user = user
    @password = password
  end
end

class Publication
  attr_reader :name
  def initialize(name)
    @name = name
  end
  def template(path)
    path+"template"
  end
  def static(path)
    path+"static"
  end
end

class Remote
  attr_reader :name, :host, :port, :credentials
  def initialize(name, host, port, credentials)
    @name = name
    @host = host
    @port = port
    @credentials = credentials
  end

  def password
    credentials.password
  end

  def user
    credentials.user
  end

  def publication_dir(publication_name)
    "/opt/tomcat-#{name}/webapps-#{publication_name}/#{publication_name}/"
  end
end

class Local
  attr_reader :project_home
  def initialize(project_home)
    @project_home = project_home
  end
  def publication_dir(publication_name)
    "#{project_home}/publications/#{publication_name}/src/main/webapp/"
  end
end

class Environment
  attr_reader :publications, :local, :remote
  def initialize(remote, local, publication_names)
    @publications = publication_names.map{|n| Publication.new(n)}
    @local = local
    @remote = remote
  end
end

class Uploader
  def upload_template(environment)
    environment.publications.each do |pub|
      p 'Syncing templates...'
      p pub.template(environment.local.publication_dir(pub.name)) => environment.remote.publication_dir(pub.name)
      Net::SCP.upload!(environment.remote.host, environment.remote.user, pub.template(environment.local.publication_dir(pub.name)), environment.remote.publication_dir(pub.name), :ssh => {:port => environment.remote.port}, :recursive => true)
      p pub.template(environment.local.publication_dir("shared-war")) => environment.remote.publication_dir(pub.name)
      Net::SCP.upload!(environment.remote.host, environment.remote.user, pub.template(environment.local.publication_dir("shared-war")), environment.remote.publication_dir(pub.name), :ssh => {:port => environment.remote.port}, :recursive => true)
      p 'Templates synced.'
    end
  end
  def upload_static(environment)
    environment.publications.each do |pub|
      p 'Syncing statics...'
      p pub.static(environment.local.publication_dir(pub.name)) => pub.static(environment.remote.publication_dir(pub.name))
      Net::SCP.upload!(environment.remote.host, environment.remote.user, pub.static(environment.local.publication_dir(pub.name)), environment.remote.publication_dir(pub.name), :ssh => {:port => environment.remote.port}, :recursive => true)
      p pub.static(environment.local.publication_dir("shared-war")) => pub.static(environment.remote.publication_dir(pub.name))
      Net::SCP.upload!(environment.remote.host, environment.remote.user, pub.static(environment.local.publication_dir("shared-war")), environment.remote.publication_dir(pub.name), :ssh => {:port => environment.remote.port}, :recursive => true)
      p 'Statics synced.'
    end
  end
  def upload(environment)
    upload_template(environment)
    upload_static(environment)
  end
end
