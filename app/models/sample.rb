class Sample < ActiveRecord::Base
  belongs_to :piste

  enum state: [ :open, :in_preparation, :closed ]
end
