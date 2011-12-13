module MobileRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc <<DESC
Description:
    Install mobile_rails into your app.
DESC
      def add_mobile_mine_type
        initializer("mobile_rails.rb") do
          'Mime::Type.register_alias "text/html", :mobile'
        end
        application(nil, :env => "production") do
          "config.assets.precompile += %w(mobile.css mobile.js)"
        end
      end
    end
  end
end