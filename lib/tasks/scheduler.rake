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

namespace :compact do
  task pistes: :environment do
    Piste.all.each do |piste|
      last_state = nil
      piste.samples.order(:updated_at).each do |sample|
        if sample.state == last_state
          sample.destroy
        else
          last_state = sample.state
        end
      end
    end
  end
end
