module MobileRails
  module ControllerAdditions
    module InstanceMethods
      def mobile?
        request.user_agent.to_s.downcase =~ Regexp.new(MobileRails::MOBILE_USER_AGENTS)
      end

      def mobile_layout
        mobile? ? "mobile" : 'application' 
      end

      def set_mobile_request
        request.format = :mobile if mobile?
      end
    end
    module ClassMethods
      def has_mobile_rails
        before_filter :set_mobile_request

        helper_method :mobile?
        layout :mobile_layout
      end
    end
  end
end


ActionController::Base.send(:extend, MobileRails::ControllerAdditions::ClassMethods)
ActionController::Base.send(:include, MobileRails::ControllerAdditions::InstanceMethods)

