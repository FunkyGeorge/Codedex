var mongoose = require('mongoose');
var Task = mongoose.model('Task');

module.exports = (function() {
	return {

		//get all customers
		index: function(req, res) {
			Task.find({}, function(err, results) {
				if (err) {
					console.log(err);
				} else {
					// console.log(results)
					res.json(results);
				}
			})
		},

		//add a task
		create: function(req, res) {
			var task = new Task(req.body);
			task.save(function(err, results) {
				if (err) {
					console.log(err)
					res.json(err);
				} else {
					res.json(results);
				}
			})
		},

		//update a task
		update: function(req, res) {
			console.log("here")
			console.log(req.params.id)
			console.log(req.body.objective)
			Task.update({_id: req.params.id}, {objective: req.body.objective}, function(err) {
				if (err) {
					console.log(err)
				} else {
					res.json({})
				}
			})
		},

		//delete a task
		delete: function(req, res) {
			console.log(req.params.id);
			Task.remove({_id: req.params.id}, function(err) {
				if (err) {
					res.json(err);
				} else {
					console.log("successfully deleted task")
					res.json({});
				}
			});
		}


	}

})();