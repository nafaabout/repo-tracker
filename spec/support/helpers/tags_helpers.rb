module TagsHelpers
  def generate_tags_response_body(count)
    count.times.map do |idx|
      { 'id' => idx, 'name' => Faker::ProgrammingLanguage.name }
    end
  end
end
