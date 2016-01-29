module Layer
  module Api
    module Users
      def get_blocklist(user_id)
        get("users/#{user_id}/blocks")
      end

      def block_user(owner_id, user_id)
        params = { user_id: user_id }
        post("users/#{owner_id}/blocks", body: params.to_json)
      end

      def unblock_user(owner_id, user_id)
        delete("users/#{owner_id}/blocks/#{user_id}")
      end

      def get_users_messages(user_id, conversation_id)
        get("users/#{user_id}/conversations/#{conversation_id}/messages")
      end

      def get_users_message(user_id, message_id)
        get("users/#{user_id}/messages/#{message_id}")
      end
    end
  end
end
