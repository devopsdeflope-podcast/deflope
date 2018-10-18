require 'google_drive'
require 'git'

git = Git.open('.')
gdrive = GoogleDrive::Session.from_service_account_key("devopsdeflopeci-54630c3d0a4b.json")

changed_posts = git.log.first.diff_parent.stats[:files].map do |file|
    file[0] if file[0].include?('posts') and file[0].include?('md')
end.compact

puts "We don't need to download episodes, because they weren't changed" && exit(0) if changed_posts.empty?

changed_posts.each do |post|
    episode_number = /\d{3}(?=\.md)/.match(post)[0]

    puts "Downloading episode number #{episode_number} to source/mp3/..."
    gdrive.file_by_title("deflope#{episode_number}.mp3")
          .download_to_file("./source/mp3/deflope#{episode_number}.mp3")

    puts "Episode number #{episode_number} successfully downloaded!"
end