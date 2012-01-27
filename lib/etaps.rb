require "etaps/version"

module Etaps

  def self.run(source='production')
    unless File.file?('config/database.yml')
     $stderr.puts "No config/database.yml found!"
     exit 1
    end

    require 'erb'
    require 'childprocess'

    config = YAML.load(ERB.new(File.read('config/database.yml')).result)
    source = build_url(config[source])
    target = build_url(config['development'])

    server = ChildProcess.build("taps", "server", source, "a", "b")
    server.io.inherit!
    server.io.stdout = File.open('/dev/null', 'w')
    server.start

    sleep 10

    unless server.alive?
      exit 1
    end

    client = ChildProcess.build("taps", "pull", target, "http://a:b@localhost:5000")
    client.io.inherit!
    client.start
    client.wait

  ensure
    client.stop rescue nil
    server.stop rescue nil
  end


  def self.build_url(conf)
    type = conf['adapter']
    __send__("build_#{type}_url", conf)
  end

  def self.build_sqlite_url(conf)
    "sqlite://#{File.expand_path(conf['database'])}"
  end

  def self.build_sqlite3_url(conf)
    build_sqlite_url(conf)
  end

  def self.build_mysql_url(conf)
    "mysql://#{conf['username']}:#{conf['password']}@#{conf['host']}/#{conf['database']}"
  end

  def self.build_mysql2_url(conf)
    build_mysql_url(conf)
  end

end
