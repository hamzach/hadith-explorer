class CategorizationController < ApplicationController


	def add_category
		
		categories = params[:categories].to_a
		hadithid = params[:hadith_id]
		@name = ""
		if categories.nil?
			HadithCategory.delete_all(hid: "#{hadithid.to_s}")
		else
			categoryNames = Category.where("cname in (?)",categories)
			for categoryid in categoryNames
				obj = HadithCategory.new
				obj.cid = categoryid.cid
				obj.hid = hadithid
				obj.save
			end
		end		
		render text: categoryNames.to_json
	end
end