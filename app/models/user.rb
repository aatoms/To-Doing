class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  has_many :memberships, :dependent => :destroy
  has_many :projects, through: :memberships
  has_many :comments, :dependent => :nullify

  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end

  def show_tracker_tokenf
    plain_text = tracker_token[0,4]
    plain_text + ('*' * (tracker_token.delete plain_text).length)
  end

end
