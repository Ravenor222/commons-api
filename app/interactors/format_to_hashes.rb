# frozen_string_literal: true

class FormatToHashes
  include Interactor
  # Called by write_to_db organizer
  # Parses the XML file into an array of hashes

  def call
    legisinfo_xml = context.data
    hash = JSON.parse(Hash.from_xml(legisinfo_xml).to_json)
    items = hash['rss']['channel']['item']
    if items.present?
      context.data = items
    else
      context.fail!(message: 'Formatting to hashes failed!')
    end
  end
end
