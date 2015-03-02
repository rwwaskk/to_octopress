# ToOctopress

A simple gem for generating octopress markdown files from PostgreSQL database (e.g Rails) 

## Installation

Add this line to your application's Gemfile:

    gem 'to_octopress'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install to_octopress

## Usage

	require 'to_octopress'

	ToOctopress.to_octopress(database_name,table_name,timestamp_column,slug_column,content_column,title_column,path_to_zip_file)
	
Example,
	ToOctopress.to_octopress('blogs_database',"blogs","updated_at","slug","content","title",File.dirname(__FILE__))


A file to_octoress.zip will be generated. It contains the list of markdown files compatible with octopress name conventions and yaml setup

## Contributing

1. Fork it ( http://github.com/<my-github-username>/to_octopress/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
