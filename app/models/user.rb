require 'digest'

class User < ActiveRecord::Base
 attr_accessor :password

 attr_accessible :first_name,:last_name,:username,:password, :password_confirmation,:is_admin,:role_id


has_many :mobileusers

validates_uniqueness_of :username

 validates_presence_of :first_name,:last_name,:username,:password,:password_confirmation
 validates :password,  :confirmation => true
 
before_save :encrypt_password
before_create { generate_token(:auth_token) }


def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while User.exists?(column => self[column])
end

def has_password?(submitted_password)
  encrypted_password == encrypt(submitted_password)
end

class << self
  def authenticate(username, submitted_password)
    user = find_by_username(username)
    (user && user.has_password?(submitted_password)) ? user :nil
  end

  def authenticate_with_salt(id,cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user :nil
  end 
end

 def role?(role)
 	    return Role.find_by_name(role).name
 end

private

def encrypt_password
self.salt = make_salt if new_record?
  if password.class == Float
    a = password
    a = a.to_i.to_s
    self.encrypted_password = encrypt(a)
  else
   self.encrypted_password = encrypt(password)
  end
end

def encrypt(string)
secure_hash("#{salt}--#{string}")
end

def make_salt
  if password.class == Float
    a = password
    a = a.to_i.to_s
   secure_hash("#{Time.now.utc}--#{a}")
  else
  secure_hash("#{Time.now.utc}--#{password}")
  end
end

def secure_hash(string)
Digest::SHA2.hexdigest(string)
end



def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  users ||= []
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    user = find_by_id(row["id"]) || new
    user.attributes = row.to_hash.slice(*accessible_attributes)
    users << user
    # user.save!
    # UserRole.create(:user_id => user.id , :role_id => user.role_id,:name => user.first_name)
  end
  return users
end



def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
  when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
  when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end




end
