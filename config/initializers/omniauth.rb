Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, :fields => [:name, :email]
  provider :twitter, 'L6JfNpaiOACtuaW9nP2kA', 'D8Pn2CkEXcHwrvv2lKV2fyejDkFuiOoWtABe1bQIQM'
  provider :github, 'f6d9845597fb42f76380', '08665942800b0a952a71fda8269f9fc3b2cc8526'
end
