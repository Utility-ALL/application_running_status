ActiveRecord::Schema.define do
  create_table "add_machines", :force => true do |t|
    t.string "ip_address"
    t.string "port"
    t.string "proto"
  end
end
