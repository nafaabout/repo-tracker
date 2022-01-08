puts 'Creating Categories..'
['Databases', 'Frameworks', 'Programming languages', 'DevOps', 'Security'].sort.each do |category|
  Category.find_or_create_by(name: category)
end

puts 'Creating Programming Languages..'
%w[Ruby Javascript C# Java Python Elixir Golang Dart Swift].sort.each do |lang|
  category = Category.find_by(name: 'Programming languages')
  Topic.find_or_create_by(name: lang, category:)
end

puts 'Creating Databases..'
['Postgresql', 'Oracle', 'MySQL', 'MongoDB', 'Cassandra', 'SQL Server', 'Redis'].sort.each do |db|
  category = Category.find_by(name: 'Databases')
  Topic.find_or_create_by(name: db, category:)
end

puts 'Creating Frameworks..'
['Ruby On Rails', 'Django', 'ExpressJS', 'Sinatra', 'Flask', 'Hanami', 'Laravel', 'Vue', 'React',
 'React Native'].sort.each do |framework|
  category = Category.find_by(name: 'Frameworks')
  Topic.find_or_create_by(name: framework, category:)
end

puts 'Creating DevOps..'
['Infrastructure', 'Continuous Delivery', 'Automation', 'Containers', 'Cloud', 'Observability'].sort.each do |role|
  category = Category.find_by(name: 'Team roles')
  Topic.find_or_create_by(name: role, category:)
end

puts 'Creating Security..'
['Data security', 'Identity and access management', 'Network security', 'Security training and jobs',
 'Infosec programs', 'Risk management strategies', 'Information security threats', 'Network threat detection',
 'Platform security', 'Security compliance', 'Software security'].sort.each do |sec_topic|
  category = Category.find_by(name: 'Security')
  Topic.find_or_create_by(name: sec_topic, category:)
end

puts 'Creating platforms'
Platform.create_with(name: 'Dev',
                     base_url: 'https://dev.to',
                     api_url: 'https://dev.to/api').find_or_create_by(name: 'Dev')
