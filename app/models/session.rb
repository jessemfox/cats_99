# == Schema Information
#
# Table name: sessions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  session_token :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Session < ActiveRecord::Base
  validates :user_id, :session_token, :presence => true
  after_initialize :set_session_token

  belongs_to :user

  def self.create_session_token
    SecureRandom::urlsafe_base64(16)
  end



  private

  def set_session_token
    self.session_token = self.class.create_session_token
  end




end
