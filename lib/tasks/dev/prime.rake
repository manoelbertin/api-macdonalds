if Rails.env.development? || Rails.env.test?
  require 'factory_bot'

  namespace :dev do
    desc 'Sample data for local development environment'
    task prime: 'db:setup' do
      include FactoryBot::Syntax::Methods

      15.times do
        profile = [:admin, :client].sample
        create(:user, profile: profile)
      end
    end
  end
end