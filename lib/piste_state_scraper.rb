class PisteStateScraper
  GIF_VS_STATE = { '1' => :open, '2' => :in_preparation, '3' => :closed }

  def scrape
    uri = URI('http://www.infosnow.ch/~apgmontagne/?lang=en&pid=31')
    response = Net::HTTP.get(uri)
    nodes = Capybara.string(response)

    content = nodes.all('.block')[5].first('.content')
    content.all('td').each_slice(3) do |state, colour, piste|
      if (img = state.first('img')) && piste.text.present?
        gif = File.basename(img['src'], '.gif')
        yield piste.text, GIF_VS_STATE[gif]
      end
    end
  end
end
