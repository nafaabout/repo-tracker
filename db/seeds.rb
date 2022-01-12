puts 'Creating platforms'
Platform.create_with(name: 'Dev',
                     base_url: 'https://dev.to',
                     api_url: 'https://dev.to/api/').find_or_create_by(name: 'Dev')
