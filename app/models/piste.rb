class Piste < ActiveRecord::Base
  has_many :samples

  def latest_sample
    samples.order(:updated_at).last
  end

  def latest_state
    latest_sample.state
  end
end
