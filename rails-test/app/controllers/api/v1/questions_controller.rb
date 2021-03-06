class Api::V1::QuestionsController < ApiController
	skip_before_filter  :verify_authenticity_token
	before_action :validate_Api_key!
	skip_before_action :validate_Api_key!, :only => [:html_dashboard]
	respond_to :html

	def index
		return head :forbidden unless has_valid_api_key?
		questions = Question.where("title LIKE ?","%#{params[:query]}%")
		record_activity("Created new recoord")
		@data = questions.all.to_json(:include => {:user => {:only => [:id, :name] }, 
                                :answers => {:include => { :user => {:only => [:id, :name] } },
                                :only => [:id, :body] } }, 
                                :except => [:created_at, :updated_at, :user_id, :private])
		
	end

	def html_dashboard
		@users_count = User.count
		@question_count = Question.count
		@answer_count = Answer.count
		@tenants = Tenant.all
	end

	private
		def has_valid_api_key?
			Tenant.pluck(:api_key).include? params[:api_key]
		end

		def validate_Api_key!
			return head :forbidden unless has_valid_api_key?
		end
end