FactoryBot.define do
  factory :game do
    mode { %i(pvp pve both).sample }
    release_date { "2023-04-08 13:51:24" }
    developer { Faker::Company.name }
    system_requirement
  end
end
