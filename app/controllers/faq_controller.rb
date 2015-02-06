class FaqController < ApplicationController
  def index
    @quote= CommonQuestion.question
    @link= CommonQuestion.links
  end
end
