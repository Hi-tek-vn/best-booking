class CreateDatabase < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :code
      t.timestamps
    end

    create_table :currencies do |t|
      t.string :code
      t.timestamps
    end

    create_table :roles do |t|
      t.string :role_name
      t.timestamps
    end

    create_table :payment_types do |t|
      t.string :type
      t.timestamps
    end

    create_table :payments do |t|
      t.integer :user_id
      t.string :payment_type
      t.string :account_name
      t.string :card_number
      t.integer :ccv
      t.timestamp :expiry_date
      t.string :account_number
      t.string :bitcoin_id
      t.timestamps
    end

    create_table :cases do |t|
      t.integer :case_type
      t.integer :case_relation
      t.string :short_description
      t.string :case_description
      t.string :supporting_file
      t.integer :claim_sum
      t.integer :total_funds
      t.integer :case_status
      t.integer :case_duration
      t.boolean :know_defendant
      t.boolean :know_jurisdiction
      t.boolean :previous_judgement
      t.boolean :legal_strategy
      t.boolean :signed_contract
      t.integer :risk_level
      t.integer :plaintiff_payout
      t.integer :investor_payout
      t.integer :lix_payout
      t.timestamps
    end

    create_table :case_finances do |t|
      t.integer :case_id
      t.float :current_share_price
      t.string :curency
      t.float :day_high
      t.float :day_low
      t.float :alltime_high
      t.float :alltime_low
      t.float :payout_share_pc
      t.float :total_fund_required
      t.timestamps
    end

    create_table :transactions do |t|
      t.integer :user_id
      t.integer :case_id
      t.float :number_of_share
      t.float :total_amount
      t.float :transactions_fee
      t.string :currency
      t.string :paid_type
      t.timestamps
    end
  end
end
