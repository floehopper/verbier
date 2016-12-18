class PistesController < ApplicationController
  def index
    @pistes = Piste.all
    @coder = HTMLEntities.new
  end
end
