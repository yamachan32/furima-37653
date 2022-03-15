FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    nickname              { Faker::Name.initials(number: 2) }
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    last_name_ruby        { person.last.katakana }
    first_name_ruby       { person.first.katakana }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
