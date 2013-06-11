class CreateInfoPolens < ActiveRecord::Migration
  def change
    create_table :info_polens do |t|
      t.date,ANIO :FECHA

      t.timestamps
    end
  end
end
