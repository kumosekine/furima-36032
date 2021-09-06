# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| family_name        | string | null: false |
| first_name         | string | null: false |
| family_name_kana   | string | null: false |
| first_name_kana    | string | null: false |
| birthday           | date   | null: false |

### Association

- has_many :items
- has_many :purchase_records

## items テーブル

| Column        | Type       | Options     |
| ------------- | ---------  | ----------- |
| image         | text       | null: false |
| product_name  | string     | null: false |
| description   | text       | null: false |
| category      | string     | null: false |
| status        | string     | null: false |
| delivery_fee  | string     | null: false |
| shipping_area | string     | null: false |
| delivery_day  | string     | null: false |
| price         | integer    | null: false |
| user          | references | null: false, foreign_key: true |

### Association 

- belongs_to :user
- has_one :purchase_records

## purchase_records テーブル

| Column | Type       | Options                        |
| ------ | ---------  | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :item
- has_one    :shipping_address

## shipping_addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefecture    | string     | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     |                                |
| tel           | string     | null: false                    |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

- has_one :purchase_records