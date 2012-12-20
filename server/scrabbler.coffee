scrabble = rebuild: from: (sentences) ->
	
	## SHOULDNT BE IN PRODUCTION
	Words.remove()

	for sentence in sentences
		lastWasPeriod = true
		
		words = (w for w in sentence.text.split(/[\s,"!?.:;]+/) when w.length)
		# this will help us identify periods and other full stops.
		untreatedWords = (w for w in sentence.text.split(/[\s,":;]+/) when w.length)

		for word, i in words
			label = word
			value = word.toLowerCase()

			if word isnt untreatedWords[i]
				lastWasPeriod = true
			else if lastWasPeriod
				lastWasPeriod = false
				# if the word comes after a full stop, we
				# consider it's label representation to be
				# lowercase, if it already isnt; because
				# if it's not lowercase it's because it's
				# after a full stop, and not because the
				# word is intrinsically proper case (which
				# e.g. German nouns are).
				label = value if label isnt value

			entry = Words.findOne value: value
			if !(entry?)
				entry = value: value, label: label
				id = Words.insert entry
				entry._id = id

			console.log word
			# if the saved word's value is the same as it's label, yet
			# we now have an example where they diverge, update the
			# entry to reflect it's new label representation.
			if entry.value is entry label and value isnt label
				null

			Words.update id,
				$push: { appearances: sentence._id }
				$inc: { appearanceCount: 1 }
###
for sentence in sentences
	for word in sentence.words
		id = Words.findOne text: word
		if !id then id = Words.insert text: word
		console.log word
		Words.update id,
			$push: { appearances: sentence._id }
			$inc: { appearanceCount: 1 }


words = (word for word in text.split(/[\s,":;]+/) when word.length)
###
