sentencer = (sentence) ->
	words = []
	#counts = []
	sentenceWords = (w.toLowerCase() for w in sentence.words)
	Words.find({ value: {$in: sentenceWords} }, sort: {appearanceCount: 1}).map (w) ->
		words.push w.value
		#counts.push w.appearanceCount

	# drop up to 30% of the phrase's words
	drop = Math.floor (words.length * 0.3)

	for i in [0..drop]
		find = Test.find( know: { $all: words } ).fetch()
		return { sentence: sentence.text, drops: i } if find.length
		words.shift()

	return false
