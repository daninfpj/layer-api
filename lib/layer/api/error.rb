module Layer
  module Api
    class Error < StandardError
      def self.from_response(response)
        status = response[:status]

        if klass =  case status
                    when 400 then Layer::Api::BadRequest
                    when 404 then Layer::Api::NotFound
                    when 410 then Layer::Api::Gone
                    when 500..599 then Layer::Api::ServerError
                    else self
                    end
          klass.new(response)
        end
      end

      def initialize(response)
        @response = response
        super(build_error_message)
      end

      def response
        @response
      end

      private

      def build_error_message
        message = "Layer responded with status "
        message << "#{@response[:status]}: #{@response[:body]}"
        message
      end
    end

    class BadRequest < Error; end
    class NotFound < Error; end
    class Gone < Error; end
    class ServerError < Error; end
  end
end
