class Api::V1::QuestionsController < ApiController
	skip_before_filter  :verify_authenticity_token
	before_action :validate_Api_key!
	respond_to :html

	def index
		return head :forbidden unless has_valid_api_key?
		record_activity("Created new recoord")
		@data = Question.all.to_json(:include => {:user => {:only => [:id, :name] }, 
                                :answers => {:include => { :user => {:only => [:id, :name] } },
                                :only => [:id, :body] } }, 
                                :except => [:created_at, :updated_at, :user_id, :private])
		
	end

	private
		def has_valid_api_key?
			Tenant.pluck(:api_key).include? params[:api_key]
		end

		def validate_Api_key!
			return head :forbidden unless has_valid_api_key?
		end
end