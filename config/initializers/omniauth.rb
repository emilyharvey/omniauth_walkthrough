Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, :fields => [:name, :email, :username]
  provider :twitter, 'L6JfNpaiOACtuaW9nP2kA', 'D8Pn2CkEXcHwrvv2lKV2fyejDkFuiOoWtABe1bQIQM'
  provider :github, 'f6d9845597fb42f76380', '08665942800b0a952a71fda8269f9fc3b2cc8526'

  OmniAuth::Form.module_eval do
    def input_field_with_text(type, name, text)
      @html << "\n<input type='#{type}' id='#{name}' name='#{name}' value='#{text}'/>"
      self
    end

    def text_field_with_text(label, name, text)
      label_field(label, name)
      input_field_with_text('text', name, text)
      self
    end
  end

  OmniAuth::Strategies::Identity.module_eval do
  	def request_phase
        if request.get?
          signin_form(false)
        elsif request.post?
          signin_phase
        end
    end

    def signin_form(error)
      OmniAuth::Form.build(
        :title => (options[:title] || "Identity Verification")
      ) do |f|
        if error
          f.html "<font color='red'>The login and password don't match, please try again.</font>"
        end
        f.text_field 'Login', 'auth_key'
        f.password_field 'Password', 'password'
        f.html "<p align='center'><a href='#{registration_path}'>Create an Identity</a></p>"
        f.html "<p align='center'><a href='#'>Forgot Your Password</a></p>"
      end.to_response 
    end

    def signin_phase
      if (!identity)
        signin_form(true)
      else
        env['PATH_INFO'] = callback_path
        callback_phase
      end
    end

    def other_phase
      if on_registration_path?
        if request.get?
          registration_form(false,[],[])
        elsif request.post?
          registration_phase
        end
      else
        call_app!
      end
    end

    def registration_form(error, errorMessages, previousEntries)
  		  OmniAuth::Form.build(:title => 'Register Identity') do |f|
        if error
          f.html "<font color='red'>The following error(s) prevented this user from being created:"
          f.html "<ul>"
          errorMessages.each do |e|
            if (e.to_s.downcase.include? "digest")
              f.html "<li>Password can't be blank</li>"
            else
              f.html "<li>" + e.to_s + "</li>"
            end
          end
          f.html "</ul></font>"
        end
        options[:fields].each do |field|
          if error
            f.text_field_with_text field.to_s.capitalize, field.to_s, previousEntries[field].to_s
          else
            f.text_field field.to_s.capitalize, field.to_s
          end
        end
        f.password_field 'Password', 'password'
        f.password_field 'Confirm Password', 'password_confirmation'
      end.to_response
    end

    def registration_phase
      attributes = (options[:fields] + [:password, :password_confirmation]).inject({}){|h,k| h[k] = request[k.to_s]; h}
      @identity = model.new(attributes)
      @identity.save
      if @identity.save
        env['PATH_INFO'] = callback_path
        callback_phase
      else
        if options[:on_failed_registration]
          self.env['omniauth.identity'] = @identity
          options[:on_failed_registration].call(self.env)
        else
          registration_form(true, @identity.errors.full_messages, attributes)
        end
      end
    end
  end
end
