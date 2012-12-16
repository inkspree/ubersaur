### 
	for i in [0..154]
		console.log i + ' words: ' + Sentences.find({ wordCount: i }).count()
###
# do a selectible bar chart so people can choose the word count range (e.g. minimum 4 words maximum 10)
# http://square.github.com/crossfilter/
