require 'digest'

class User < ActiveRecord::Base
 attr_accessor :password

 attr_accessible :first_name,:last_name,:username,:password, :password_confirmation,:is_admin


has_many :mobileusers

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

private
def encrypt_password
self.salt = make_salt if new_record?
self.encrypted_password = encrypt(password)
end
def encrypt(string)
secure_hash("#{salt}--#{string}")
end
def make_salt
secure_hash("#{Time.now.utc}--#{password}")
end
def secure_hash(string)
Digest::SHA2.hexdigest(string)
end



end
