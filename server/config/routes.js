//server API routing
var coders = require('./../controllers/coders.js');


module.exports = function(app) {

	app.get('/name', function(req, res) {
		coders.getAll(req, res)
	})
	
	app.get('/name/:name', function(req, res) {
		coders.index(req, res)
	})

	app.post('/names', function(req, res) {
		coders.create(req, res)
	})

	// app.post('/tasks/:id', function(req, res) {
	// 	tasks.update(req, res)
	// })

	// app.delete('/tasks/:id', function(req, res) {
	// 	tasks.delete(req, res)
	// })

}