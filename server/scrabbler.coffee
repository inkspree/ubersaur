###
	for sentence in sentences
		for word in sentence.words
			id = Words.findOne text: word
			if !id then id = Words.insert text: word
			console.log word
			Words.update id,
				$push: { appearances: sentence._id }
				$inc: { appearanceCount: 1 }
###
