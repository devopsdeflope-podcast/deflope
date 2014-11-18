require 'fog'

set :aws_bucket, "devopsdeflope.ru"

namespace :deploy do

  task :default do

    if File.exists?("export.yml")
      key_file = YAML.load(File.read("export.yml"))
      ENV['S3_ACCESS_KEY'] = key_file['S3_ACCESS_KEY']
      ENV['S3_SECRET_KEY'] = key_file['S3_SECRET_KEY']
    end

    storages = [
            {
              :provider => 'AWS',
              :region => 'eu-west-1',
              :aws_access_key_id => ENV['S3_ACCESS_KEY'],
              :aws_secret_access_key => ENV['S3_SECRET_KEY']
            }
    ]


    raise "Eerro while building site" if not system "bundle exec middleman build"

    Dir.chdir("build")

    Fog.credentials = { path_style: true }

    storages.each do |storage|
      connection = Fog::Storage.new(storage)
      puts "Deploying to bucket: #{aws_bucket}"

      directory = connection.directories.get(aws_bucket)

      connection.put_bucket_website( aws_bucket, "index.html" )

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
