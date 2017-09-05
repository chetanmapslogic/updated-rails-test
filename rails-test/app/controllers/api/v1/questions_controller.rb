class Api::V1::QuestionsController < ApiController
	respond_to :html
	layout "application"
	def index
		@data = Question.all.to_json(:include => {:user => {:only => [:id, :name] }, 
                                :answers => {:include => { :user => {:only => [:id, :name] } },
                                :only => [:id, :body] } }, 
                                :except => [:created_at, :updated_at, :user_id, :private])
		# render json: @data
	end
end