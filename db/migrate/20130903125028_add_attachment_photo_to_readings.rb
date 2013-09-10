class AddAttachmentPhotoToReadings < ActiveRecord::Migration
  def self.up
    change_table :readings do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :readings, :photo
  end
end
