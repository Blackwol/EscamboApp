class Admin < ActiveRecord::Base
	
  ROLES = {:full_access => 0, :restricted_access => 1}
  enum role: ROLES

  scope :with_full_access, -> {where(role: 0)}
  scope :with_restricted_access, -> {where(role: 1)}
  # Igual à:
  #def self.with_full_access
   # where(role: 'full_access')
  #end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

#enum role:[:full_access=>0, :restricted_access=>1]
