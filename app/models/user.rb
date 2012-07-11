class User < ActiveRecord::Base
  require 'securerandom'

  # If you add some languages in locale files, add them here too. ;)
  LANGUAGES = ["fr", "en"]
  LANGUAGES_FOR_SELECT = [[ "Francais", "fr"],
                          [ "English", "en" ]]

  attr_accessible :created_at, :email, :login, :password, :salt, :time_zone, :language

  validates_confirmation_of :password
  validates_presence_of     :login
  validates_presence_of     :password, :on => :create
  validates_presence_of     :email
  validates_uniqueness_of   :email
  validates_format_of       :email,
                            :with => /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\Z/i
  validates_uniqueness_of   :login
  validates_inclusion_of    :language, :in => LANGUAGES

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

  def send_password_reset
    self.password_reset_token = SecureRandom.base64.tr("+/", "-_")
    self.password_reset_time = Time.zone.now
  end

  def to_param
    "#{login}"
  end

  def self.find_by_slug(param)
    find_by_login(param)
  end

end
