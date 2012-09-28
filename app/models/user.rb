class User < ActiveRecord::Base
  has_many :games_players, :inverse_of => :user
  has_many :created, :class_name => "Games", :inverse_of => :creator

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmiable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
