require 'open-uri'
require 'open_uri_redirections'

module Jekyll_Ubuntu_Latest
  class Generator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      release_version = get_precise_version(site.data['ubuntu_latest']['release']['version'])
      lts_version = get_precise_version(site.data['ubuntu_latest']['lts']['version'])
      site.data['ubuntu_latest']['release']['version'] = release_version
      site.data['ubuntu_latest']['lts']['version'] = lts_version
    end

    def get_precise_version(base_version)
      url = 'http://releases.ubuntu.com/'+base_version+'/SHA256SUMS'
      open(url, 'r', :allow_redirections => :all) do |remote_content|
        return /[0-9]+\.[0-9]+(\.[0-9])?/.match(remote_content.read).to_s
      end
    end

  end
end
