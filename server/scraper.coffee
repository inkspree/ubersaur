Zombie = __meteor_bootstrap__.require 'zombie'

scrapeTatoeba = ->
	Zombie.visit 'http://tatoeba.org/eng/sentences/with_audio', (e, zombie) ->
		console.log zombie.text '#audioStats .stat[title=German] .total'
	
	scrapePage 1, recursive: yes
				
scrape = (website) -> switch website
	when 'tatoeba' then scrapeTatoeba()

scrapePage = (page, options) ->
	if (Sentences.find 'source.page': page).count() is 50
		# the last page may not be seen as done since it can have less than 50 sentences
		console.log 'page #' + page + ' is done'
		if options.recursive then Fiber( -> scrapePage page + 1, options ).run()
		return
	url = 'http://tatoeba.org/eng/sentences/with_audio/deu/page:'
	Zombie.visit url + page, (e, zombie) ->
		sentences = zombie.queryAll '.sentence.mainSentence'
		console.log 'doing page ' + page
		Fiber( -> saveSentence sentence, page, zombie ).run() for sentence in sentences
		if options.recursive then Fiber( -> scrapePage page + 1, options ).run()

saveSentence = (sentence, page, zombie) ->
	href = (sentence.querySelector '.audioButton').getAttribute 'href'
	id = href.split '/'
	id = id[id.length - 1]
	id = (id.split '.')[0]

	found = Sentences.findOne 'source.id': id
	#console.log 'found?', found
	return if found
	text = zombie.text '.text', (sentence.querySelector '.sentenceContent')
	words = (word for word in text.split(/[\s,.!?":;]+/) when word.length)
	Sentences.insert
		text: text
		audio: href
		words: words
		wordCount: words.length
		language: 'german'
		source:
			name: 'tatoeba'
			id: id
			page: page
		(err, insertion) ->
			return if err?
			console.log 'inserted #' + id
