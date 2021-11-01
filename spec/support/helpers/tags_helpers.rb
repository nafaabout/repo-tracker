module TagsHelpers
  def stub_tags_request(tags:, platform: nil, query: {})
    platform ||= 'Dev'
    api_uri = Tags::Puller.api_url_for(platform)
    query[:page] ||= 1
    query[:per_page] ||= 10
    stub_request(:get, api_uri)
      .with(query: query)
      .to_return(status: 200, body: tags.to_json)
  end

  def generate_tags_response_body(count)
    count.times.map do |idx|
      { 'id' => idx, 'name' => Faker::ProgrammingLanguage.name }
    end
  end
end
