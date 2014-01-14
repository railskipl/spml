class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :pc
      t.string :bu
      t.string :consno
      t.string :disc_tag
      t.string :tag2
      t.string :yymm1
      t.string :yymm2
      t.string :mtr1
      t.string :mt1dgt
      t.string :mf1
      t.string :avgc1
      t.string :mtr1st
      t.string :rdng1
      t.string :rdmm1
      t.string :mtr2
      t.string :mt2dgt
      t.string :mf2
      t.string :avgc2
      t.string :mtr2st
      t.string :rdng2
      t.string :rdmm2
      t.string :heatcon
      t.string :oldcon
      t.string :poleno
      t.string :mrc
      t.string :route
      t.string :seq
      t.string :name
      t.string :addrs
      t.string :city
      t.string :pincode
      t.string :dtc
      t.string :trf
      t.timestamps
    end
  end
end
