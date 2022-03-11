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
| birthday           | date    | null: false               |

### Association

- has_many :items
- has_many :comments
- has_many :orders

## items テーブル

| Column         | Type       | Options                         |
| -------------- | ---------- | ------------------------------- |
| product        | string     | null: false                     |
| explanation    | text       | null: false                     |
| category_id    | integer    | null: false                     |
| state_id       | integer    | null: false                     |
| postage_id     | integer    | null: false                     |
| prefecture_id  | integer    | null: false                     |
| post_period_id | integer    | null: false                     |
| price          | integer    | null: false                     |
| user           | references | null: false , foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- has_many :comments

## comments テーブル

| Column  | Type       | Options                         |
| ------- | ---------- | ------------------------------- |
| content | text       | null: false                     |
| user    | references | null: false , foreign_key: true |
| item    | references | null: false , foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## orders テーブル

| Column | Type       | Options                         |
| ------ | ---------- | ------------------------------- |
| item   | references | null: false , foreign_key: true |
| user   | references | null: false , foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column        | Type       | Options                         |
| ------------- | ---------- | ------------------------------- |
| post_code     | string     | null: false                     |
| prefecture_id | integer    | null: false                     |
| city          | string     | null: false                     |
| block         | string     | null: false                     |
| building      | string     |                                 |
| phone_number  | string     | null: false                     |
| order         | references | null: false , foreign_key: true |

### Association

- belongs_to :order

