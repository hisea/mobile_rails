Mobile Rails 
---------------

Mobile_rails is a gem designed for integrating crossplat for mmobile web application with rails application.

What mobile_rails does:

* Adding plubming for detecting mobile device browser
* Setting up a mobile mime type as rails response format
* Adding a session variable to allow user switch between mobile and web interfaces.

Mobile_rails can be used with mobile_rails_jqm which is a gem packaged jQuery Mobile 1.0 final with a mobile_rails layout generator.

How mobile_rails works:
--------------

1 Web request stays the same.

2 Mobile request comes in, mobile layout is selected and request mime format is set to .mobile.

3 User gets a mobile optimized view of your app.

4 an link to can be given to set the preference to web so user can view the full version on mobile device.

Getting Started
---------------

Include the Gem

```
gem 'mobile_rails'
```

Run this:

```
$ bundle install
$ rails g mobile_rails:install
```

Add this in your app/controller/application_controller.rb

```
  has_mobile_rails
```

Remove require_tree . from both application.js and css.js in your app/assets directory to not load mobile.js and mobile.css.

You are almost done. 
Next step is to choose a javascript mobile framework you like, create a mobile.mobile.haml(or .erb) layout in your app/view/layout folder. 
Then in your controller allow respond_to mobile format and treat your mobile page like normal view but with a name like 'index.mobile.haml'. Web request will render the html version and mobile request will look for the .mobile.haml file.

More Info
-------------
* A 'mobile?' helper method is added to your controller and view to detect if the user is using a mobile devise.
* 'session[:mobile_session]' is used to turn on and off mobile rendering. set to '1' for on and '0' for off.

i.e.
If you want to give user a choice to view full web version on their mobile device:

 add this to your view:

```
= link_to "Web Version", home_web_url, :rel => "external"
```

then in your home_controller:

```ruby
  def web
    session[:mobile_session] = 0
    redirect_to root_url
  end
```

If you want to use jQuery Mobile, please checkout [mobile_rails_jqm](https://github.com/hisea/mobile_rails_jqm).


