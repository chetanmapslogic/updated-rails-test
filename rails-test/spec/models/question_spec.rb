require 'rails_helper'

RSpec.describe Question, :type => :model do
	config.include Requests::JsonHelpers, type: :request
end