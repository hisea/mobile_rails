module MobileRails
  module ControllerAdditions
    module InstanceMethods
      def mobile?
        request.user_agent.to_s.downcase =~ Regexp.new(MobileRails::MOBILE_USER_AGENTS)
      end

      def mobile_layout
        (mobile? && mobile_session?) ? "mobile" : 'application' 
      end

      def set_mobile_request
        if mobile?
          session[:mobile_session] = 1 if session[:mobile_session].nil?
          request.format = :mobile if mobile_session?
        end
      end
      
      def mobile_session?
        session[:mobile_session] == 1
      end
    end
    module ClassMethods
      def has_mobile_rails
        self.send(:include, MobileRails::ControllerAdditions::InstanceMethods)
        before_filter :set_mobile_request

        helper_method :mobile?
        layout :mobile_layout
      end
    end
  end
end

if defined? ActionController
  ActionController::Base.send(:extend, MobileRails::ControllerAdditions::ClassMethods)
end

