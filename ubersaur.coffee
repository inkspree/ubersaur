Sentences = new Meteor.Collection 'sentences.german'
Words = new Meteor.Collection 'words.german'

if Meteor.isServer
	#console.log Sentences.find({}, sort: { wordCount: -1 }).map (s) -> s.text
	console.log 'count', Sentences.find().count()

	sentences = Sentences.find( {}, field: { _id: 1, text: 1, words: 1, wordCount: 1, } ).fetch()
	
	#console.log 'words', Words.find({}, limit: 50, sort: { appearanceCount: -1 }).map (w) -> w.appearanceCount + ' ' + w.text
	
	console.log Words.find(appearanceCount: 10).count()

	#scrape 'tatoeba'

if Meteor.isClient
	Meteor.setTimeout ( -> console.log Sentences.findOne() ), 1000

	# mention
	# http://en.wikipedia.org/wiki/Speech_shadowing

	Template.ubercontext.events = {}
	_.extend Template.ubercontext,
		sentences: ->

# build a word appearence collection (in how many sentences does each word appear)

# run a query for each sentence (20,000?), searching for the user db for which users know all words of that sentence e.g. { $all: { words: sentenceWordsArray } }
# then run a query for each sentence with the most uncommon words leftout (some more 40,000 maybe), taken from the word appearance collection

# pricing plans
# free 30-day trial
# $5/mo. Simple Stegosaurus plan (1 language, billed monthly)
# $25 for a year Singleminded Spinosaurus (1 language, billed yearly)
# $40 for a year Polyglot Pterodactyl (unlimeted languages, billed yearly)
# use a dinosaur comparing to human silhoute in each plan
# https://www.google.com/search?q=dinosaur+silhouette+vector&aq=1&oq=dinosaur+silhou&aqs=chrome.4.57j60l2j0l3.5128&sugexp=chrome,mod=11&sourceid=chrome&ie=UTF-8#hl=en&tbo=d&sclient=psy-ab&q=dinosaur+skeleton+silhouette+vector&oq=dinosaur+skeleton+silhouette+vector&gs_l=serp.3...32598.33677.0.34156.9.9.0.0.0.8.226.1754.0j7j2.9.0.les%3B..0.0...1c.1._1Lvtu3REI0&pbx=1&bav=on.2,or.r_gc.r_pw.r_cp.r_qf.&bvm=bv.1355325884,d.eWU&fp=1334c0493d1d1e56&bpcl=39967673&biw=1280&bih=679
