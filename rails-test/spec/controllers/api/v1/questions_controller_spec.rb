require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
	describe "Questions API" do
	  it 'sends a list of questions' do
	    FactoryGirl.create_list(:question, 10)

	    

	    json = JSON.parse(response.body)

	    # # test for the 200 status-code
	    expect(response).to be_success

	    # # check to make sure the right amount of questions are returned
	    expect(json['questions'].length).to eq(10)
	  end
	end
end