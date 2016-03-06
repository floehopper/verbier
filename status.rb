require 'bundler/setup'

require 'net/http'
require 'capybara'

uri = URI('http://www.infosnow.ch/~apgmontagne/?lang=en&pid=31')
response = Net::HTTP.get(uri)
nodes = Capybara.string(response)

GIF_VS_STATUS = { '1' => 'open', '2' => 'in preparation', '3' => 'closed' }

content = nodes.all('.block')[5].first('.content')
content.all('td').each_slice(2) do |status, piste|
  if img = status.first('img')
    gif = File.basename(img['src'], '.gif')
    p [piste.text, GIF_VS_STATUS[gif]]
  end
end
