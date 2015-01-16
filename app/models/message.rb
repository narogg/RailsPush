class Message < ActiveRecord::Base
 validates :msg, :presence => { :message => " nemores praznan slati, kuku" }
end
