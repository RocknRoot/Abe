class User < ActiveRecord::Base
  attr_accessible :created_at, :email, :login, :password, :salt, :time_zone

  validates_confirmation_of :password
  validates_presence_of     :login
  validates_presence_of     :password, :on => :create
  validates_presence_of     :email
  validates_uniqueness_of   :email
  validates_format_of       :email,
                            :with => /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\Z/i
  validates_uniqueness_of   :login

  has_many :tags
  has_many :comments, :dependent => :nullify
  has_many :categories, :dependent => :destroy
  has_many :terms, :dependent => :destroy

  def self.authenticate(login, password)
    user = find_by_login(login)
    if user && user.password == BCrypt::Engine.hash_secret(password, user.salt)
      return user
    end
    return nil
  end

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, salt)
    end
  end
end
