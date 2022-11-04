FactoryBot.define do
  factory :admin_user do
    user_name { 'テスト' }
    email { 'test@icloud.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end
  factory :user do
    user_name { 'テスト花子' }
    email { 'testhanako@icloud.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end