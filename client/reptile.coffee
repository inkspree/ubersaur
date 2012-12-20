Meteor.absoluteUrl 'all'

if Meteor.isClient
	Template.outreach.events = {}
	
	Template.featured.events = {}
	_.extend Template.featured,
		'click .tile': (e) -> Session.set 'selected', 'hey'
