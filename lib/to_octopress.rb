require "to_octopress/version"
require 'pg'
require 'reverse_markdown'

require 'rubygems'
require 'zip'

module ToOctopress
  	def self.to_octopress(db_name,table_name,timestamp_name,slug_name,content_name,title_name,current_dir)
  	conn = PGconn.open(:dbname => db_name)
  	query = "SELECT to_char("+timestamp_name+",'YYYY-MM-DD') as updated_at, "+slug_name+" as slug, "+ content_name+" as content, "+title_name +" as title from "+table_name 
	res  = conn.exec(query)

	file_names=[]
	res.each do |entry|

		updated_at= entry['updated_at'] # '1'
		slug=entry['slug'] # '1'
		content=entry['content']
		thetitle = entry['title']


		title = current_dir+"/"+updated_at+'-'+slug+'.markdown'
		markdown_content = ReverseMarkdown.convert content
		
		File.open(title, "w") do |f|  
			f.write("---\n")
			f.write("layout: post\n")
			f.write('title: "'+thetitle+'"')
			f.write "\n"
			f.write("date: "+updated_at)
			f.write "\n"
			f.write("comments: true\n")
			f.write("categories: \n")
			f.write("---\n\n")     
			f.write(markdown_content)   
			file_names<<updated_at+'-'+slug+'.markdown'
		end
	end

	Zip.on_exists_proc = true
	Zip.continue_on_exists_proc = true
	
	folder = current_dir
	zipfile_name = folder+"/to_octopress.zip"

	Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
	  file_names.each do |filename|
	    zipfile.add(filename, folder + '/' + filename)
	  end
	end

	file_names.each do |filename|
		File.delete(current_dir+"/"+filename)
	end
  end
end
