class Conversation < ActiveRecord::Base
	validates_uniqueness_of :starter, :scope => :target
end
