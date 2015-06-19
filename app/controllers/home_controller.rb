class HomeController < ApplicationController	


	def index
		if session[:user_type] == "admin"
			redirect_to :action => "adminView"
		else
			@HadithId = []
			@favHadith= []
			if(session[:user_id])
				@favHadith = Collection.select("hadith_id").where("user_id = ?", session[:user_id])
				for x in @favHadith
					@HadithId << x.hadith_id
				end
			end

			hadithCategories = getHadithCategories
			@hadiths_chapters = getAllChapters
			result = getAllHadiths

			@hadiths = getAhadiths result, hadithCategories
			# render text: "#{@hadiths.to_s}"
		end
	end

	def adminView
		@scholars = User.where("usertype = ?", "scholar")
	end

	def category

		topic = "#{params[:topicName].to_s}"
		if session[:user_type] == "admin"
			redirect_to :action => "adminView"
		else
			@HadithId = []
			@favHadith= []
			if(session[:user_id])
				@favHadith = Collection.select("hadith_id").where("user_id = ?", session[:user_id])
				for x in @favHadith
					@HadithId << x.hadith_id
				end
			end

			hadithCategories = getHadithCategories
			@hadiths_chapters = getAllChapters
			if topic != "All"
				query_str = "prefix : <http://protege.org/ontologies/Hadith.owl#>
						 SELECT ?HId ?Content ?Topic ?BookName (group_concat(?Names; SEPARATOR = '-->>') as ?Narrator)
						 WHERE 
						 {
						 	?Hadith :HId ?HId ;
		 							:Content ?Content ;
		 							:Topic ?Topic ;
		 							:hasNarrator ?Narrators .
		 					?Narrators :PName ?Names .
		 					?Book :Title ?BookName
		 					FILTER (str(?Topic) = '#{topic}') .
						 }
						 GROUP BY ?HId ?Content ?Topic ?BookName
						 "
			hadith = SPARQL.execute(query_str, @@queryable)
			@hadiths = getAhadiths hadith, hadithCategories
			else
				redirect_to action: "index"
			end
			# render text: "#{@hadiths.to_s}"
		end
	end


	def advanceSearch
		@HadithId = []
		@favHadith= []
		if(session[:user_id])
			@favHadith = Collection.select("hadith_id").where("user_id = ?", session[:user_id])
			for x in @favHadith
				@HadithId << x.hadith_id
			end
		end
		book = params[:bookText].to_s
		narrator = params[:narratorText].to_s
		topic = params[:topicText].to_s
		category = params[:categoryText].to_s

		hadithCategories = getHadithCategories
		result = getAllHadiths
		allHadiths = getAhadiths result, hadithCategories

		bookFilter = Array.new
		topicFilter = Array.new
		narratorsFilter = Array.new
		categoryFilter = Array.new

		hadiths = allHadiths

		if !book.empty?
			bookFilter = byBookName allHadiths, book
			hadiths = bookFilter
		end
		
		if !topic.empty?
			topicFilter = byTopicName hadiths, topic
			hadiths = topicFilter
		end

		if !narrator.empty?
			narratorsFilter = byNarratorName hadiths, narrator
			hadiths = narratorsFilter
		end

		if !category.empty?
			categoryFilter = byCategoryName hadiths, category
			hadiths = categoryFilter
		end

		html = ""
		hadiths.each { |hadith|
		html += '<div class="row col-lg-12 hadith pull-right">
					<div class="category-wrapper pull-right">
						<div class="category pull-right">
							<div class="col-lg-12 pull-right ">
								<a href="#" class="pull-right some">'+hadith['topic']+'</a>
							</div>
						</div>
					</div>
		 			<div class="row col-lg-12 narrators">'
						hadith['narrators'].each { |index|
						html += '<span><a href="" style="color:black;">'+index+'</a>&nbsp'
						# if(index != hadith['narrators'].size)
						# {
							html += '<span class="glyphicon glyphicon-link" aria-hidden="true"></span>';
						# }
							html += '</span>';
						}

					html += '</div>'
					html +=	'<div class="row col-lg-12 narrators">
								 <div id='+hadith['id']+'_categories_container>'
									if hadith['categories'].any?
										hadith['categories'].each{ |index|
											html += '<p class="row col-lg-2" style="display:inline-flex;">'+index+'</p>'
										}
									else
										html += 'The hadith is yet to be categorized.'
									end
							html += '</div>
					</div>
					<div class="row col-lg-12 no-padding"></div>
					<div class="row col-lg-12 matan no-padding">
						<p href="">'+hadith['matan']+'</p>
					</div>'
				if current_user
					html += '<div class="row col-lg-12 controls no-padding">
								<div class="col-lg-3 controls no-padding">'
								if @HadithId.include?(hadith['id'])
									html += '<button type="submit" id="lk" class="btn btn-primary add-collection active-button" style="width:95%;" value= "'+hadith["id"]+'">
												<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>&nbsp&nbspRemove from collection
											</button>'
								else
									html += '<button type="submit" id="lk" class="btn btn-primary add-collection" style="width:95%;" value= "'+hadith["id"]+'" >
												<span class="glyphicon glyphicon-heart" aria-hidden="true"></span>&nbsp&nbspAdd to my collection
											</button>'
								end
								html += '</div>'
								if session[:user_type] == "scholar"
									html += '<div class="col-lg-2 controls no-padding">
												<button type="button" id="lk" class="btn btn-primary editCategory" style="width:106%;" value= "'+hadith["id"]+'">
													<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>&nbsp&nbspEdit Category
												</button>
											</div>'
								end
					html += '</div>'
				end
				html += '</div>'
		}

		render text: html.to_json
	end

	def categorizedAhadith
		if session[:user_type] == "admin"
			redirect_to :action => "adminView"
		else
			@HadithId = []
			@favHadith= []
			if(session[:user_id])
				@favHadith = Collection.select("hadith_id").where("user_id = ?", session[:user_id])
				for x in @favHadith
					@HadithId << x.hadith_id
				end
			end

			hadithCategories = getHadithCategories
			@hadiths_chapters = getAllChapters
			result = getAllHadiths
			hadith = getAhadiths result, hadithCategories

			@hadiths = splitCategorized hadith
			# render text: "#{@hadiths.to_s}"
		end
	end

	def unCategorizedAhadith
		if session[:user_type] == "admin"
			redirect_to :action => "adminView"
		else
			@HadithId = []
			@favHadith= []
			if(session[:user_id])
				@favHadith = Collection.select("hadith_id").where("user_id = ?", session[:user_id])
				for x in @favHadith
					@HadithId << x.hadith_id
				end
			end

			hadithCategories = getHadithCategories
			@hadiths_chapters = getAllChapters
			result = getAllHadiths
			hadith = getAhadiths result, hadithCategories

			@hadiths = splitUnCategorized hadith
			# render text: "#{@hadiths.to_s}"
		end
	end

	def editProfile
		render 'editProfile'
	end

	def signIn
		render 'signIn'
	end

	def signUp
		render 'signUp'
	end

private

	@@root = Rails.root.to_s
	@@queryable = RDF::Repository.load("#{@@root}/ontology/Narrators.nt")
	def getAllHadiths
		query_str = "prefix : <http://protege.org/ontologies/Hadith.owl#>
			 SELECT ?HId ?Content ?Topic ?BookName (group_concat(?Names; SEPARATOR = '-->>') as ?Narrator)
			 WHERE 
			 {
			 	?Hadith :HId ?HId ;
							:Content ?Content ;
							:Topic ?Topic ;
							:hasNarrator ?Narrators ;
							:hasContainer ?Book .
					?Narrators :PName ?Names .
					?Book :Title ?BookName

			 }
			 GROUP BY ?HId ?Content ?Topic ?BookName
			 "
		result = SPARQL.execute(query_str, @@queryable)
		return result
	end

	def getAllChapters
		query_str = "prefix : <http://protege.org/ontologies/Hadith.owl#>
			 SELECT ?ChapterName
			 WHERE 
			 {
			 	?Chapter:CName ?ChapterName .
			 }"

		result = SPARQL.execute(query_str, @@queryable)	
		return result
	end

	def getHadithCategories

		sql = "select categories.cname, hadith_categories.hid
			    from hadith_categories, categories
			    where hadith_categories.cid = categories.cid"

		result = ActiveRecord::Base.connection.execute(sql)
		return result
	end

	def getAhadiths(result, hadithCategories)

		hadiths = Array.new

		temp = hadithCategories.to_a
		result.each do |item|
			categories_set = Array.new	
			temp.each { |c|
				if item['HId'].to_s == c[1].to_s
					categories_set << c[0].to_s
				end
			}
			hadith = Hash.new
			hadith['id'] = item['HId'].to_s
			hadith['narrators'] = item['Narrator'].to_s.split("-->>")
			hadith['categories'] = categories_set
			hadith['topic'] = item['Topic'].to_s
			hadith['matan'] = item['Content'].to_s
			hadith['reference'] = "some referen"
			hadith['book'] = item['BookName'].to_s
			hadiths.push(hadith)
		end

		return hadiths
	end

	def byBookName(hadiths, book)
		result = Array.new
		
		hadiths.each { |hadith|
			if hadith['book'].downcase.include? book.downcase 
				result.push(hadith)
			end
		}
		return result
	end

	def byTopicName(hadiths, topic)
		result = Array.new
		hadiths.each { |hadith|
			if hadith['topic'].downcase.include? topic.downcase
				result.push(hadith)
			end
		}
		return result
	end

	def byNarratorName(hadiths, narrator)
		result = Array.new
		hadiths.each { |hadith|
			hadith['narrators'].each { |item|
				if item.downcase.include? narrator.downcase
					result.push(hadith)
				break
				end
			}
		}
		return result
	end

	def byCategoryName(hadiths, category)
		result = Array.new
		hadiths.each { |hadith|
			hadith['categories'].each { |item|
				if item.downcase.include? category.downcase 
					result.push(hadith)
				break
				end
			}
		}
		return result
	end

	def splitCategorized(result)
		categorizedHadith = Array.new
		result.each { |hadith|
			if hadith['categories'].any?
				categorizedHadith.push(hadith)
			end
		}
		return categorizedHadith
	end

	def splitUnCategorized(result)
		unCategorizedHadith = Array.new
		result.each { |hadith|
			if !hadith['categories'].any?
				unCategorizedHadith.push(hadith)
			end
		}
		return unCategorizedHadith
	end
end
