module AlbumsHelper
  def album_header(album)
    <<-HTML.html_safe
    <h1>#{h(album.name)} #{"(#{h(album.recording_year)})" if album.recording_year}</h1>
    <h2>#{h(album.band.name)}</h2>
    HTML
  end
end
