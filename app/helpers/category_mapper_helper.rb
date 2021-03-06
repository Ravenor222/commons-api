# frozen_string_literal: true

module CategoryMapperHelper
  # Map from Canada RSS feed category to uClassify category names
  def self.map(full_category_name)
    map = {
      "Agriculture, environment, fisheries and natural resources": 'agriculture_environment',
      "Arts, culture and entertainment": 'arts_culture',
      "Business, industry and trade": 'business_industry',
      "Economics and finance": 'economics_finance',
      "Education, language and training": 'education_language',
      "Employment and labour": 'employment_labour',
      "Government, Parliament and politics": 'government_politics',
      "Health and safety": 'health_safety',
      "Indigenous affairs": 'indigenous_affairs',
      "Information and communications": 'information_communications',
      "International affairs and defence": 'international_affairs',
      "Law, justice and rights": 'law_justice',
      "Science and technology": 'science_technology',
      "Social affairs and population": 'social_affairs'
    }
    map[:"#{full_category_name}"]
  end
end
