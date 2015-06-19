class CollectionController < ApplicationController
	
	def show_collection
		if session[:user_id] != nil
			root = Rails.root.to_s
			@favHadith = Collection.select("hadith_id").where("user_id = ?", session[:user_id])
			
			sql = "	select categories.cname, hadith_categories.hid
				    from hadith_categories, categories
				    where hadith_categories.cid = categories.cid"

			@hadithCategories = ActiveRecord::Base.connection.execute(sql)
			@HadithId = []
			for x in @favHadith
				@HadithId << x.hadith_id
			end
			
			queryable = RDF::Repository.load("#{root}/ontology/Narrators.nt")
			query_str = "prefix : <http://protege.org/ontologies/Hadith.owl#>
						 SELECT ?ChapterName
						 WHERE 
						 {
						 	?Chapter:CName ?ChapterName .
						 }"

			@solutions1 = SPARQL.execute(query_str, queryable)
			query_str = "prefix : <http://protege.org/ontologies/Hadith.owl#>
						 SELECT ?HId ?Content ?Topic (group_concat(?Names; SEPARATOR = '-->>') as ?Narrator)
						 WHERE 
						 {
						 	?Hadith :HId ?HId ;
		 							:Content ?Content ;
		 							:Topic ?Topic ;
		 							:hasNarrator ?Narrators .
		 					?Narrators :PName ?Names .
						 }
						 GROUP BY ?HId ?Content ?Topic
						 "
			@solutions = SPARQL.execute(query_str, queryable)

			@topic = -1
		else
			render text: "Some thing goes worng, Please try again later"
		end



	end

	def add_collection
		if session[:user_id] != nil
			userid = session[:user_id]
			hadithid = params[:hadith_id]
			btnText = params[:button_text]

			if btnText.include?("Add to my collection")
				c = Collection.new
				c.user_id = userid
				c.hadith_id = hadithid
				c.save
				render text: "added"
			elsif btnText.include?("Remove from collection")
				redirect_to action: "remove_collection", id: "#{hadithid}"
			end
		else
			render text: "Some thing goes worng, Please try again later"
		end
	end

	def remove_collection
		if session[:user_id] != nil
			hadithid = params[:id].to_s
			userid = session[:user_id]
			Collection.where("user_id = #{userid} AND hadith_id = '#{hadithid}'").delete_all
			#render text: "deleted"
		else
			render text: "Some thing goes worng, Please try again later"
		end
	end
	def remove_all_collection
		if session[:user_id] != nil
			Collection.where("user_id = #{session[:user_id]}").delete_all
		else
			render text: "Some thing goes worng, Please try again later"
		end
		#render text: "deleted"
	end
end
