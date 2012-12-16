Pad = new Meteor.Collection 'pad'
#Pad.remove({})
#Pad.insert words: ['one', 'two', 'three']
#Pad.insert words: ['one', 'two']
#Pad.insert words: ['one', 'five']
#Pad.insert words: ['one', 'two', 'five']
#Pad.insert words: ['one', 'two', 'five']
#Pad.insert words: ['one']

Sentences = new Meteor.Collection 'sentences'
Words = new Meteor.Collection 'words'

if Meteor.isServer
	#console.log Sentences.find({}, sort: { wordCount: -1 }).map (s) -> s.text
	console.log 'count', Sentences.find().count()
	sentences = Sentences.find( {}, field: { words: 1, wordCount: 1, } ).fetch()

	#scrape 'tatoeba'

if Meteor.isClient
	Meteor.setTimeout ( -> console.log Sentences.findOne() ), 1000

	# mention
	# http://en.wikipedia.org/wiki/Speech_shadowing

	Template.ubercontext.events = {}
	_.extend Template.ubercontext,
		sentences: ->


# check that I got all pages (zombie might have missed loading a few)

# build a word appearence collection (in how many sentences does each word appear)

# run a query for each sentence (20,000?), searching for the user db for which users know all words of that sentence e.g. { $all: { words: sentenceWordsArray } }
# then run a query for each sentence with the most uncommon words leftout (some more 40,000 maybe), taken from the word appearance collection
