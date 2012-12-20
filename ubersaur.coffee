Sentences = new Meteor.Collection 'sentences.german'
Words = new Meteor.Collection 'words.german'
Test = new Meteor.Collection 'test'

if Meteor.isServer
	#console.log Sentences.find({}, sort: { wordCount: -1 }).map (s) -> s.text
	sentences = Sentences.find( {}, field: { _id: 1, text: 1, words: 1, wordCount: 1, } ).fetch()
	
	#console.log 'words', Words.find({}, limit: 50, sort: { appearanceCount: -1 }).map (w) -> w.appearanceCount + ' ' + w.text

	# http://www.manythings.org/tatoeba/
	# http://www.manythings.org/ipad/listen/jazz.html
	# http://www.manythings.org/audio/sentences/
	# http://stackoverflow.com/questions/8893135/using-cc-by-sa-music-in-a-closed-source-game


	Test.remove()
	Test.insert know: ['der', 'das', 'die', 'im', 'in', 'an', 'am', 'gut', 'tasche', 'tisch', 'madchen', 'junge', 'jung', 'alt', 'geld', 'gelb', 'blau', 'weiß', 'mann', 'frau', 'geht', 'ist', 'es', 'sind', 'blume', 'blumen', 'baum', 'bäume', 'gebäude', 'mir', 'ich', 'dich', 'mich', 'auto', 'tür', 'lampe', 'sofa', 'artz', 'bett', 'sohn', 'mutter' , 'ja', 'jahr', 'nicht', 'neue', 'morgen', 'nacht', 'acht', 'ein', 'eins', 'kein', 'groß', 'klein', 'eine', 'keine', 'zwei', 'drei', 'vier', 'fünf', 'hund', 'hunde', 'haus', 'häuser', 'sechs', 'neune', 'zanzig', 'zehn', 'schlecht', 'schreibe', 'trinkt', 'essen', 'ess', 'esszimmer', 'zimmer', 'badezimmer', 'schlaufe', 'laufe', 'läufe', 'gehe', 'stehe', 'steht', 'geht', 'buch', 'koch', 'stuhl']
	
	finds = []

	console.log Test.findOne()
	count = 0
	###
	for sentence in sentences
		match = sentencer sentence
		continue unless match

		list = switch match.drops
			when 0 then 'know'
			else "know-#{match.drops}"
		pusher = {}
		pusher[list] = userid
		Sentences.update sentence._id, $push: pusher
		#finds.push match if match
	###
	console.log f for f in finds


	console.log Words.findOne()

	
	console.log 'done'


	#scrape 'tatoeba'
	#scrabble.rebuild.from sentences

if Meteor.isClient
	layoutPhrases = ->
		console.log $('#phrases').outerWidth()
		console.log $('#phrases').outerHeight()
		'#68ffb9' # aqua green
		'#6afffc' # aqua blue
		'#b4ff06' # lime green 
	
	$ -> Meteor.defer ->
		layoutPhrases()

		$(window).resize layoutPhrases

	Meteor.setTimeout ( ->
		console.log Sentences.findOne()
	), 1000

	# mention
	# http://en.wikipedia.org/wiki/Speech_shadowing

	Template.ubercontext.events = {}
	_.extend Template.ubercontext,
		sentences: ->

# build a word appearence collection (in how many sentences does each word appear)

# run a query for each sentence (20,000?), searching for the user db for which users know all words of that sentence e.g. { $all: { words: sentenceWordsArray } }
# then run a query for each sentence with the most uncommon words leftout (some more 40,000 maybe), taken from the word appearance collection


# offer an API where people do a GET with a word I respond with a list of sentences with their sound links
# can at most pass a language level (basic, intermediate), but not list of known words
# this will allow mobile apps (dictionaries) to use it, instead of competing by creating their own
# charge for heavy access


# frequency analysis
	# semantic class
	# http://www.plosone.org/article/info:doi/10.1371/journal.pone.0007678?imageURI=info:doi/10.1371/journal.pone.0007678.g001
	# https://www.google.com/search?q=word+semantic+class&oq=word+semantic+class&aqs=chrome.0.57j60j59l3j60.3083&sugexp=chrome,mod=11&sourceid=chrome&ie=UTF-8
	
	# http://www.wordfrequency.info/	
	# http://www.usingenglish.com/articles/word-frequency-analysis-as-way-to-improve-writing-quality.html
	# http://imonad.com/seo/wikipedia-word-frequency-list/
	# http://en.wikipedia.org/wiki/ternary_search_tree
	# http://en.wikipedia.org/wiki/frequency_list


# pricing plans
# free 30-day trial
# $5/mo. simple stegosaurus plan (1 language, billed monthly)
# $25 for a year singleminded spinosaurus (1 language, billed yearly)
# $40 for a year polyglot pterodactyl (unlimeted languages, billed yearly)
# use a dinosaur comparing to human silhoute in each plan
# http://upload.wikimedia.org/wikipedia/commons/1/1f/largestdinosaursbysuborder_scale.png
# https://www.google.com/search?q=dinosaur+silhouette+vector&aq=1&oq=dinosaur+silhou&aqs=chrome.4.57j60l2j0l3.5128&sugexp=chrome,mod=11&sourceid=chrome&ie=utf-8#hl=en&tbo=d&sclient=psy-ab&q=dinosaur+skeleton+silhouette+vector&oq=dinosaur+skeleton+silhouette+vector&gs_l=serp.3...32598.33677.0.34156.9.9.0.0.0.8.226.1754.0j7j2.9.0.les%3b..0.0...1c.1._1lvtu3rei0&pbx=1&bav=on.2,or.r_gc.r_pw.r_cp.r_qf.&bvm=bv.1355325884,d.ewu&fp=1334c0493d1d1e56&bpcl=39967673&biw=1280&bih=679
