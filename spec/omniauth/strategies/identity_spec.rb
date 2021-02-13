class MockIdentity; end

RSpec.describe OmniAuth::Strategies::Identity do
  attr_accessor :app

  let(:auth_hash){ last_response.headers['env']['omniauth.auth'] }
  let(:identity_hash){ last_response.headers['env']['omniauth.identity'] }

  # customize rack app for testing, if block is given, reverts to default
  # rack app after testing is done
  def set_app!(identity_options = {})
    old_app = self.app
    self.app = Rack::Builder.app do
      use Rack::Session::Cookie, secret: '1234567890qwertyuiop'
      use OmniAuth::Strategies::Identity, identity_options
      run lambda{|env| [404, {'env' => env}, ["HELLO!"]]}
    end
    if block_given?
      yield
      self.app = old_app
    end
    self.app
  end

  before(:all) do
    set_app!(:model => MockIdentity)
  end

  describe '#request_phase' do
    context 'with default settings' do
      it 'displays a form' do
        set_app!(:model => MockIdentity)
        get '/auth/identity'

        expect(last_response.body).not_to eq("HELLO!")
        expect(last_response.body).to be_include("<form")
      end
    end

    context "when login is enabled" do
      context "when registration is enabled" do
        it 'displays a form with a link to register' do
          set_app!(:model => MockIdentity, :enable_registration => true, :enable_login => true)
          get '/auth/identity'

          expect(last_response.body).not_to eq("HELLO!")
          expect(last_response.body).to be_include("<form")
          expect(last_response.body).to be_include("<a")
          expect(last_response.body).to be_include("Create an Identity")
        end
      end

      context "when registration is disabled" do
        it 'displays a form without a link to register' do
          set_app!(:model => MockIdentity, :enable_registration => false, :enable_login => true)
          get '/auth/identity'

          expect(last_response.body).not_to eq("HELLO!")
          expect(last_response.body).to be_include("<form")
          expect(last_response.body).not_to be_include("<a")
          expect(last_response.body).not_to be_include("Create an Identity")
        end
      end
    end

    context "when login is disabled" do
      context "when registration is enabled" do
        it 'bypasses registration form' do
          set_app!(:model => MockIdentity, :enable_registration => true, :enable_login => false)
          get '/auth/identity'

          expect(last_response.body).to eq("HELLO!")
          expect(last_response.body).not_to be_include("<form")
          expect(last_response.body).not_to be_include("<a")
          expect(last_response.body).not_to be_include("Create an Identity")
        end
      end

      context "when registration is disabled" do
        it 'displays a form without a link to register' do
          set_app!(:model => MockIdentity, :enable_registration => false, :enable_login => false)
          get '/auth/identity'

          expect(last_response.body).to eq("HELLO!")
          expect(last_response.body).not_to be_include("<form")
          expect(last_response.body).not_to be_include("<a")
          expect(last_response.body).not_to be_include("Create an Identity")
        end
      end
    end
  end

  describe '#callback_phase' do
    let(:user){ double(:uid => 'user1', :info => {'name' => 'Rockefeller'})}

    context 'with valid credentials' do
      before do
        allow(MockIdentity).to receive('auth_key').and_return('email')
        expect(MockIdentity).to receive('authenticate').with({'email' => 'john'},'awesome').and_return(user)
        post '/auth/identity/callback', :auth_key => 'john', :password => 'awesome'
      end

      it 'populates the auth hash' do
        expect(auth_hash).to be_kind_of(Hash)
      end

      it 'populates the uid' do
        expect(auth_hash['uid']).to eq('user1')
      end

      it 'populates the info hash' do
        expect(auth_hash['info']).to eq({'name' => 'Rockefeller'})
      end
    end

    context 'with invalid credentials' do
      before do
        allow(MockIdentity).to receive('auth_key').and_return('email')
        OmniAuth.config.on_failure = lambda{|env| [401, {}, [env['omniauth.error.type'].inspect]]}
        expect(MockIdentity).to receive(:authenticate).with({'email' => 'wrong'},'login').and_return(false)
        post '/auth/identity/callback', :auth_key => 'wrong', :password => 'login'
      end

      it 'fails with :invalid_credentials' do
        expect(last_response.body).to eq(':invalid_credentials')
      end
    end

    context 'with auth scopes' do

      it 'evaluates and pass through conditions proc' do
        allow(MockIdentity).to receive('auth_key').and_return('email')
        set_app!(:model => MockIdentity, :locate_conditions => lambda{|req| {model.auth_key => req['auth_key'], 'user_type' => 'admin'} } )
        expect(MockIdentity).to receive('authenticate').with( {'email' => 'john', 'user_type' => 'admin'}, 'awesome' ).and_return(user)
        post '/auth/identity/callback', :auth_key => 'john', :password => 'awesome'
      end
    end
  end

  describe '#registration_form' do
    context 'registration is enabled' do
      it 'triggers from /auth/identity/register by default' do
        get '/auth/identity/register'
      expect(last_response.body).to be_include("Register Identity")
      end
    end

    context 'registration is disabled' do
      it 'calls app' do
        set_app!(:model => MockIdentity, :enable_registration => false)
        get '/auth/identity/register'
        expect(last_response.body).to be_include("HELLO!")
      end
    end
    it 'should support methods other than GET and POST' do
      head '/auth/identity/register'
      expect(last_response.status).to eq(404)
    end
  end

  describe '#registration_phase' do
    context 'registration is disabled' do
      it 'calls app' do
        set_app!(:model => MockIdentity, :enable_registration => false)
        post '/auth/identity/register'
        expect(last_response.body).to eq("HELLO!")
      end
    end

    context 'with successful creation' do
      let(:properties){ {
        :name => 'Awesome Dude',
        :email => 'awesome@example.com',
        :password => 'face',
        :password_confirmation => 'face'
      } }

      before do
        allow(MockIdentity).to receive('auth_key').and_return('email')
        m = double(:uid => 'abc', :name => 'Awesome Dude', :email => 'awesome@example.com', :info => {:name => 'DUUUUDE!'}, :persisted? => true)
        expect(MockIdentity).to receive(:create).with(properties).and_return(m)
      end

      it 'sets the auth hash' do
        post '/auth/identity/register', properties
        expect(auth_hash['uid']).to eq('abc')
      end
    end

    context 'with invalid identity' do
      let(:properties) { {
        :name => 'Awesome Dude',
        :email => 'awesome@example.com',
        :password => 'NOT',
        :password_confirmation => 'MATCHING'
      } }
      let(:invalid_identity) { double(:persisted? => false) }

      before do
        expect(MockIdentity).to receive(:create).with(properties).and_return(invalid_identity)
      end

      context 'default' do
        it 'shows registration form' do
          post '/auth/identity/register', properties
          expect(last_response.body).to be_include("Register Identity")
        end
      end

      context 'custom on_failed_registration endpoint' do
        it 'sets the identity hash' do
          set_app!(:model => MockIdentity, :on_failed_registration => lambda{|env| [404, {'env' => env}, ["FAIL'DOH!"]]}) do
            post '/auth/identity/register', properties
            expect(identity_hash).to eq(invalid_identity)
            expect(last_response.body).to be_include("FAIL'DOH!")
          end
        end
      end
    end
  end
end
