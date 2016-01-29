module Layer
  module Api
    module Conversations
      def get_conversation(conversation_id)
        get("conversations/#{conversation_id}")
      end

      def create_conversation(params = {})
        post("conversations", body: params.to_json)
      end

      def edit_conversation(conversation_id, params = {})
        patch("conversations/#{conversation_id}",
          body: params.to_json,
          headers: layer_patch_header
        )
      end

      def delete_conversation(conversation_id)
        delete("conversations/#{conversation_id}")
      end

      def send_message(conversation_id, message = {})
        post("conversations/#{conversation_id}/messages",
          body: message.to_json
        )
      end

      def get_messages(conversation_id)
        get("conversations/#{conversation_id}/messages")
      end

      def get_message(conversation_id, message_id)
        get("conversations/#{conversation_id}/messages/#{message_id}")
      end

      def get_stripped_id(raw_id)
        raw_id.sub("layer:///conversations/", "")
      end

      def get_message_stripped_id(raw_id)
        raw_id.sub("layer:///messages/", "")
      end
    end
  end
end
