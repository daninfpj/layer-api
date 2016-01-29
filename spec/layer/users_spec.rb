require 'spec_helper'

describe Layer::Api::Users do
  before do
    @layer = Layer::Api::Client.new(
      api_token: ENV['LAYER_API_TOKEN'],
      app_id: ENV['LAYER_APP_ID']
    )
  end

  describe ".get_blocklist" do
    it "should return a users blocklist" do
      VCR.use_cassette('user') do
        blocklist = @layer.get_blocklist("testuser")
        expect(blocklist).to be_instance_of(Array)
      end
    end
  end

  describe ".block_user" do
    it "should add a user to another users blocklist" do
      VCR.use_cassette('user') do
        test_user = "test"
        blocked_user = "blocked"
        @layer.block_user(test_user, blocked_user)

        blocklist = @layer.get_blocklist(test_user)
        expect(blocklist).to include({"user_id" => blocked_user})
      end
    end
  end

  describe ".unblock_user" do
    it "should remove a user from another users blocklist" do
      VCR.use_cassette('user') do
        test_user = "testdelete"
        blocked_user = "newblocked"

        @layer.block_user(test_user, blocked_user)
        @layer.unblock_user(test_user, blocked_user)
        blocklist = @layer.get_blocklist(test_user)

        expect(blocklist).to eq([])
      end
    end
  end

  describe ".get_users_messages" do
    it "should retrive messages from a conversation using a user perspective" do
      VCR.use_cassette('conversation') do
        conversation = @layer.create_conversation(conversation_params)
        id = @layer.get_stripped_id(conversation["id"])

        message = @layer.send_message(id, message_params)

        VCR.use_cassette('user', exclusive: true) do
          messages = @layer.get_users_messages(message_params[:sender][:user_id], id)

          expect(messages[0]["conversation"]["id"]).to eq(conversation["id"])
          expect(messages[0]["parts"].count).to eq(message_params[:parts].count)
          expect(messages[0]["sender"]["name"]).to eq(message_params[:sender][:name])
        end
      end
    end
  end

  describe ".get_users_message" do
    it "should retrive a message from a conversation using a user perspective" do
      VCR.use_cassette('conversation') do
        conversation = @layer.create_conversation(conversation_params)
        id = @layer.get_stripped_id(conversation["id"])

        created_message = @layer.send_message(id, message_params)

        message_id = @layer.get_message_stripped_id(created_message["id"])

        VCR.use_cassette('user', exclusive: true) do
          message = @layer.get_users_message(message_params[:sender][:user_id], message_id)

          expect(message["conversation"]["id"]).to eq(conversation["id"])
          expect(message["parts"].count).to eq(message_params[:parts].count)
          expect(message["sender"]["name"]).to eq(message_params[:sender][:name])
        end
      end
    end
  end
end
