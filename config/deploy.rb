require 'fog'

set :aws_bucket, "devopsdeflope.ru"

namespace :deploy do

  task :default do

    storages = [
            {
              :provider => 'AWS',
              :host => "storage.io",
              :aws_access_key_id => ENV['ES3_ACCESS_KEY'],
              :aws_secret_access_key => ENV['ES3_SECRET_KEY']
            }
    ]

    raise "Eerro while building site" if not system "bundle exec middleman build"

    Dir.chdir("build")

    storages.each do |storage|
      connection = Fog::Storage.new(storage)
      puts "Deploying to bucket: #{aws_bucket}"

      directory = connection.directories.create(
        :key    => aws_bucket,
        :public => true
      )

      connection.put_bucket_website( aws_bucket, "index.html", :key => "404.html" )

      all_files = []
      remote_all_files = directory.files.all.map { |file| file.key }

      Dir.glob("**/*").each { |file|

        if File.file? file

          all_files << file

          remote_file_meta = directory.files.head(file)
          local_digest = Digest::MD5.hexdigest(File.read(file))

          if remote_file_meta.nil? || remote_file_meta.etag != local_digest
            puts "Uploading #{file}"
            metadata = {}
            metadata = { 'Cache-Control' => 'public, max-age=31536000' } if file =~ /\.(png|jpg|js|css|gif)$/
            directory.files.create(
              :key => file,
              :body => File.open(file),
              :public => true,
              :metadata => metadata
            )
          else
            puts "File #{file} is unchanged, skipping"
          end
        end
      }

      (remote_all_files - all_files).each do |file|
        puts "Removing #{file}"
        directory.files.new(:key => file).destroy
      end

      puts "Deployed to #{aws_bucket}!"
    end

  end

end
