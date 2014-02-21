# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password
  # after_initialize :ensure_session_token
  validates :username, :uniqueness  => true, :presence => true
  validates :password_digest, :presence => { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  # validates :session_token, :presence => true

  has_many :cats

  def password=(pt)
    @password = pt
    self.password_digest = BCrypt::Password.create(pt)
  end

  def is_password?(pt)
    BCrypt::Password.new(self.password_digest).is_password?(pt)
  end


  def self.find_by_credentials(params)
    user = User.find_by_username(params[:username])
    if user.nil?
      return
    end
    user.is_password?(params[:password]) ? user : nil
  end


end
