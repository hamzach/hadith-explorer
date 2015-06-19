class DemoController < ApplicationController


  def index 
  	@hadith = "(ROOT
  (X
    (NP (NNP حَدَّثَنَا) (NNP عَلِيُّ) (NNP بْنُ) (NNP عَبْدِ) (NNP اللَّهِ) (NNP ،) (NNP قَالَ) (NNP حَدَّثَنَا) (NNP سُفْيَانُ) (NNP ،) (NNP قَالَ) (NNP حَفِظْنَاهُ) (NNP مِنَ) (NNP الزُّهْرِيِّ) (NNP عَنْ) (NNP سَعِيدِ) (NNP بْنِ) (NNP الْمُسَيَّبِ) (NNP ،) (NNP عَنْ) (NNP أَبِي) (NNP هُرَيْرَةَ) (NNP ،) (NNP عَنِ) (NNP النَّبِيِّ) (NNP صلى) (NNP الله) (NN عليه) (NN وسلم))))"
	#render :text => hadith

	@test = 'حَدَّثَنَا'
	@narrators = Array.new
	@nounPhrases = Array.new
	narrator = String.new
	nounPhrase = String.new
	iterator = 0
	narratorIterator = 0 
	hadithLength = @hadith.length

	loopCondition = 1
	stack = 0
	variable = false
	#incrementLoop = false
	while iterator < hadithLength 
		
		if @hadith[iterator] == "(" and @hadith[iterator+1] == "N" and @hadith[iterator+2] == "P" 
			stack += 1
			variable = true

		elsif @hadith[iterator] == ")" and stack > 0 
			stack -= 1
			
			if stack == 0
			
				@nounPhrases.push(nounPhrase)
				nounPhrase = ""
				variable = false
				#narratorIterator += 1
			end
		
			
		elsif @hadith[iterator] == "(" and variable == true
			stack += 1

		end
		

		if variable == true and @hadith[iterator] != "(" and @hadith[iterator] != ")" and @hadith[iterator] !~ /[A-Z]/
			nounPhrase << @hadith[iterator]
		end
		
		iterator += 1
	end

	iterator = 0
	narratorIterator = 0
	breakloop = false
	@nounPhrases.each do |element|
	#@test = 0
		while iterator < element.length
			
			if element[iterator] == "ق" and element[iterator+1] == "َ" and element[iterator+2] == "ا" and element[iterator+3] == "ل" and element[iterator+4] == "َ"
				
				if narrator.strip.length != 0

					@narrators.push(narrator)
					narrator = ""
					#narratorIterator += 1

				end
				iterator += 4

			elsif element[iterator] == "ع" and element[iterator+1] == "َ" and element[iterator+2] == "ن" and element[iterator+3] == "ْ"
				if narrator.strip.length != 0

					@narrators.push(narrator)
					narrator = ""
					#narratorIterator += 1
				end
				iterator += 3

			elsif element[iterator] == "ح" and element[iterator+1] == "َ" and element[iterator+2] == "د" and element[iterator+3] == "ّ" and element[iterator+4] == "َ" and element[iterator+5] == "ث" and element[iterator+6] == "َ" and element[iterator+7] == "ن" and element[iterator+8] == "َ" and element[iterator+9] == "ا" 
				if narrator.strip.length != 0
				
					@narrators.push(narrator)
					narrator = ""
					#narratorIterator += 1
					
				end
				iterator += 9
				
			elsif element[iterator] == "'" and element[iterator+1] == "'"
				if narrator.strip.length != 0
				
					@narrators.push(narrator)
					narrator = ""
					#narratorIterator += 1
					
				end
				breakloop = true
				break
			elsif element[iterator] == "،"
				iterator += 1
					
			else
				narrator << element[iterator]
			end
			iterator += 1
			#@test = iterator
		end
		if breakloop == true
			break
		end
		iterator = 0
		
	end
	
	end
end
