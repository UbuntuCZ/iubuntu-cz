require 'open-uri'
require 'open_uri_redirections'

module Jekyll_Get_Remote_Content
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      config = site.config['remote_content']
      if !config
        return
      end
      if !config.kind_of?(Array)
        config = [config]
      end
      config.each do |remote|
        open(remote['url'], 'r', :allow_redirections => :all) do |remote_content|
          open('remoteContent/'+remote['name'], 'wb') do |local_file|
            local_file.write(remote_content.read)
          end
        end
      end
    end

  end
end
