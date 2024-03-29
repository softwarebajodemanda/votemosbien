module PartyHelper
  def thumb(image, size: [64, 64], options: {} )
    image_tag(image.variant(resize_and_pad: size ), options) if image && image.variable?
  end

  def thumb_url(image, size: [64, 64], options: {} )
    url_for(image.variant(resize_and_pad: size )) if image && image.variable?
  end

  def party_attribute(party, field)
    case field
    when :web
      link_to party.read_attribute(field), "http://#{party.read_attribute(field)}", target: :_blank
    when :enrollment_date
      l(party.read_attribute(field), format: :short) rescue nil
    when :phones, :agents
      party.read_attribute(field).join(" | ")
    else
      party.read_attribute(field)
    end
  end
end