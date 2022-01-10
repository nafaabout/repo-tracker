# frozen_string_literal: true

class Puller
  attr_reader :platform

  def initialize(platform)
    @platform = platform
  end

  def pull(resource, page: 1, per_page: 10)
    page = Faraday.get(api_url(resource), { page:, per_page: })
    resources = JSON.parse(page.body)
    @have_more = resources.size == per_page

    yield resources, have_more? if block_given?

    resources
  end

  def have_more?
    @have_more
  end

  def api_url(resource)
    Utils::UrlBuilder.api_url_for(platform, resource)
  end
end
