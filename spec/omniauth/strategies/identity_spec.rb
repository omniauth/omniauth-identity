# frozen_string_literal: true

RSpec.describe OmniAuth::Strategies::Identity do
  attr_accessor :app

  let(:auth_hash) { last_response.headers['env']['omniauth.auth'] }
  let(:identity_hash) { last_response.headers['env']['omniauth.identity'] }
  let(:identity_options) { {} }
  let(:anon_ar) do
    AnonymousActiveRecord.generate(
      parent_klass: 'OmniAuth::Identity::Models::ActiveRecord',
      columns: OmniAuth::Identity::Model::SCHEMA_ATTRIBUTES | %w[provider password_digest],
      connection_params: { adapter: 'sqlite3', encoding: 'utf8', database: ':memory:' }
    ) do
      def balloon
        '🎈'
      end
    end
  end

  # customize rack app for testing, if block is given, reverts to default
  # rack app after testing is done
  def set_app!(identity_options = {})
    old_app = app
    self.app = Rack::Builder.app do
      use Rack::Session::Cookie, secret: '1234567890qwertyuiop'
      use OmniAuth::Strategies::Identity, identity_options
      run ->(env) { [404, { 'env' => env }, ['HELLO!']] }
    end
    if block_given?
      yield
      self.app = old_app
    end
    app
  end

  before do
    opts = identity_options.reverse_merge({ model: anon_ar })
    set_app!(opts)
  end

  describe '#request_phase' do
    context 'with default settings' do
      let(:identity_options) { { model: anon_ar } }

      it 'displays a form' do
        get '/auth/identity'

        expect(last_response.body).not_to eq('HELLO!')
        expect(last_response.body).to be_include('<form')
      end
    end

    context 'when login is enabled' do
      context 'when registration is enabled' do
        let(:identity_options) { { model: anon_ar, enable_registration: true, enable_login: true } }

        it 'displays a form with a link to register' do
          get '/auth/identity'

          expect(last_response.body).not_to eq('HELLO!')
          expect(last_response.body).to be_include('<form')
          expect(last_response.body).to be_include('<a')
          expect(last_response.body).to be_include('Create an Identity')
        end
      end

      context 'when registration is disabled' do
        let(:identity_options) { { model: anon_ar, enable_registration: false, enable_login: true } }

        it 'displays a form without a link to register' do
          get '/auth/identity'

          expect(last_response.body).not_to eq('HELLO!')
          expect(last_response.body).to be_include('<form')
          expect(last_response.body).not_to be_include('<a')
          expect(last_response.body).not_to be_include('Create an Identity')
        end
      end
    end

    context 'when login is disabled' do
      context 'when registration is enabled' do
        let(:identity_options) { { model: anon_ar, enable_registration: true, enable_login: false } }

        it 'bypasses registration form' do
          get '/auth/identity'

          expect(last_response.body).to eq('HELLO!')
          expect(last_response.body).not_to be_include('<form')
          expect(last_response.body).not_to be_include('<a')
          expect(last_response.body).not_to be_include('Create an Identity')
        end
      end

      context 'when registration is disabled' do
        let(:identity_options) { { model: anon_ar, enable_registration: false, enable_login: false } }

        it 'displays a form without a link to register' do
          get '/auth/identity'

          expect(last_response.body).to eq('HELLO!')
          expect(last_response.body).not_to be_include('<form')
          expect(last_response.body).not_to be_include('<a')
          expect(last_response.body).not_to be_include('Create an Identity')
        end
      end
    end
  end

  describe '#callback_phase' do
    let(:user) { double(uid: 'user1', info: { 'name' => 'Rockefeller' }) }

    context 'with valid credentials' do
      before do
        allow(anon_ar).to receive('auth_key').and_return('email')
        expect(anon_ar).to receive('authenticate').with({ 'email' => 'john' }, 'awesome').and_return(user)
        post '/auth/identity/callback', auth_key: 'john', password: 'awesome'
      end

      it 'populates the auth hash' do
        expect(auth_hash).to be_kind_of(Hash)
      end

      it 'populates the uid' do
        expect(auth_hash['uid']).to eq('user1')
      end

      it 'populates the info hash' do
        expect(auth_hash['info']).to eq({ 'name' => 'Rockefeller' })
      end
    end

    context 'with invalid credentials' do
      before do
        allow(anon_ar).to receive('auth_key').and_return('email')
        OmniAuth.config.on_failure = ->(env) { [401, {}, [env['omniauth.error.type'].inspect]] }
        expect(anon_ar).to receive(:authenticate).with({ 'email' => 'wrong' }, 'login').and_return(false)
        post '/auth/identity/callback', auth_key: 'wrong', password: 'login'
      end

      it 'fails with :invalid_credentials' do
        expect(last_response.body).to eq(':invalid_credentials')
      end
    end

    context 'with auth scopes' do
      let(:identity_options) do
        { model: anon_ar, locate_conditions: lambda { |req|
                                               { model.auth_key => req['auth_key'], 'user_type' => 'admin' }
                                             } }
      end

      it 'evaluates and pass through conditions proc' do
        allow(anon_ar).to receive('auth_key').and_return('email')
        expect(anon_ar).to receive('authenticate').with({ 'email' => 'john', 'user_type' => 'admin' },
                                                        'awesome').and_return(user)
        post '/auth/identity/callback', auth_key: 'john', password: 'awesome'
      end
    end
  end

  describe '#registration_form' do
    context 'registration is enabled' do
      it 'triggers from /auth/identity/register by default' do
        get '/auth/identity/register'
        expect(last_response.body).to be_include('Register Identity')
      end
    end

    context 'registration is disabled' do
      let(:identity_options) { { model: anon_ar, enable_registration: false } }

      it 'calls app' do
        get '/auth/identity/register'
        expect(last_response.body).to be_include('HELLO!')
      end
    end

    it 'supports methods other than GET and POST' do
      head '/auth/identity/register'
      expect(last_response.status).to eq(404)
    end
  end

  describe '#registration_phase' do
    context 'registration is disabled' do
      let(:identity_options) { { model: anon_ar, enable_registration: false } }

      it 'calls app' do
        post '/auth/identity/register'
        expect(last_response.body).to eq('HELLO!')
      end
    end

    context 'with successful creation' do
      let(:properties) do
        {
          name: 'Awesome Dude',
          email: 'awesome@example.com',
          password: 'face',
          password_confirmation: 'face',
          provider: 'identity'
        }
      end

      it 'sets the auth hash' do
        post '/auth/identity/register', properties
        expect(auth_hash['uid']).to match(/\d+/)
        expect(auth_hash['provider']).to eq('identity')
      end
    end

    context 'with invalid identity' do
      let(:properties) do
        {
          name: 'Awesome Dude',
          email: 'awesome@example.com',
          password: 'NOT',
          password_confirmation: 'MATCHING',
          provider: 'identity'
        }
      end
      let(:invalid_identity) { double(persisted?: false, save: false) }

      before do
        expect(anon_ar).to receive(:new).with(properties).and_return(invalid_identity)
      end

      context 'default' do
        it 'shows registration form' do
          post '/auth/identity/register', properties
          expect(last_response.body).to be_include('Register Identity')
          expect(last_response.body).to be_include('One or more fields were invalid')
        end
      end

      context 'custom on_failed_registration endpoint' do
        let(:identity_options) do
          { model: anon_ar, on_failed_registration: lambda { |env|
                                                      [404, { 'env' => env }, ["FAIL'DOH!"]]
                                                    } }
        end

        it 'sets the identity hash' do
          post '/auth/identity/register', properties
          expect(identity_hash).to eq(invalid_identity)
          expect(last_response.body).to be_include("FAIL'DOH!")
          expect(last_response.body).not_to be_include('One or more fields were invalid')
        end
      end
    end
  end
end
