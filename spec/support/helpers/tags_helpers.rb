module TagsHelpers
  def stub_tags_request(tags:, query: { page: 1, per_page: 10 })
    stub_request(:get, Tags::Pullers::DevTo::API_URI)
      .with(query: query)
      .to_return(status: 200, body: tags.to_json)
  end

  def generate_tags_response_body(count)
    count.times.map do |idx|
      { 'id' => idx, 'name' => Faker::ProgrammingLanguage.name }
    end
  end
end
