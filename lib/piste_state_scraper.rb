class PisteStateScraper
  GIF_VS_STATE = { '1' => :open, '2' => :in_preparation, '3' => :closed }
  GIF_VS_GRADE = { '16' => :itinerary, '15' => :black, '14' => :red, '13' => :blue }

  def scrape
    uri = URI('http://www.infosnow.ch/~apgmontagne/?lang=en&pid=31')
    response = Net::HTTP.get(uri)
    nodes = Capybara.string(response)

    content = nodes.all('.block')[5].first('.content')
    content.all('td').each_slice(3) do |state, grade, piste|
      state_img = img = state.first('img')
      grade_img = img = grade.first('img')
      if state_img && grade_img && piste.text.present?
        state_gif = File.basename(state_img['src'], '.gif')
        grade_gif = File.basename(grade_img['src'], '.gif')
        yield piste.text, GIF_VS_STATE[state_gif], GIF_VS_GRADE[grade_gif]
      end
    end
  end
end
