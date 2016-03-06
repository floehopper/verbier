class PistesController < ApplicationController
  def index
    @pistes = Piste.all
  end
end
