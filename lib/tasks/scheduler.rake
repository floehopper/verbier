require 'piste_state_scraper'

namespace :scrape do
  task pistes: :environment do
    scraper = PisteStateScraper.new
    scraper.scrape do |name, state|
      piste = Piste.find_or_create_by!(name: name)
      piste.samples.create!(state: state)
    end
  end
end
