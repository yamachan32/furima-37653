# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| email              | string  | null: false , unique:true |
| encrypted_password | string  | null: false               |
| nickname           | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_ruby     | string  | null: false               |
| first_name_ruby    | string  | null: false               |
| birth_year_id      | integer | null: false               |
| birth_month_id     | integer | null: false               |
| birth_day_id       | integer | null: false               |


### Association

- has_many :items
- has_many :comments

## items テーブル

| Column         | Type       | Options                         |
| -------------- | ---------- | ------------------------------- |
| products       | string     | null: false                     |
| explanation    | text       | null: false                     |
| category_id    | integer    | null: false                     |
| state_id       | integer    | null: false                     |
| postage_id     | integer    | null: false                     |
| post_area_id   | integer    | null: false                     |
| post_period_id | integer    | null: false                     |
| price          | integer    | null: false                     |
| user_id        | references | null: false , foreign_key: true |

### Association

- belongs_to :users
- has_one :orders
- has_many :comments

## comments テーブル

| Column  | Type       | Options                         |
| ------- | ---------- | ------------------------------- |
| content | text       | null: false                     |
| user_id | references | null: false , foreign_key: true |
| item_id | references | null: false , foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## orders テーブル

| Column        | Type       | Options                         |
| ------------- | ---------- | ------------------------------- |
| post_code     | string     | null: false                     |
| prefecture_id | integer    | null: false                     |
| city          | integer    | null: false                     |
| block         | integer    | null: false                     |
| building      | integer    | null: false                     |
| phone_number  | integer    | null: false                     |
| item_id       | references | null: false , foreign_key: true |

### Association

- belongs_to :item
