module ApplicationHelper

  def auth_token
    <<-HTML.html_safe
    <input type="hidden"
           name="authenticity_token"
           value="#{form_authenticity_token}" >
    HTML
  end

  def listed_options(list, reference)
    html = ""

    sort(list).each do |item|
      html += <<-HTML
        "<option value="#{item.id}" #{"selected" if item.id == reference.id}>
        #{h(short_name(item.name))}</option>"
      HTML
    end

    html.html_safe
  end

  def short_name(band)
    output = band[0..19].strip
    output += "..." if band.length > 20
    output
  end

  def sort(objs)
    objs.sort_by { |obj| obj.name }
  end

end
