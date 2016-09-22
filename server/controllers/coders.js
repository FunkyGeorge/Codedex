var mongoose = require('mongoose');
var Coder = mongoose.model('Coder');

module.exports = (function() {
	return {

		//get one coder
		index: function(req, res) {
			Coder.find({"name": req.params.name}, function(err, results) {
				if (err) {
					console.log(err);
				} else {
					// console.log(results)
					res.json(results);
				}
			})
		},
		getAll: function(req, res) {
			Coder.find({}, function(err, results) {
				if (err) {
					console.log(err);
				} else {
					res.json(results);
				}
			})
		},

		//add a coder
		create: function(req, res) {
			var coder = new Coder(req.body);
			console.log(coder);
			coder.save(function(err, results) {
				if (err) {
					console.log(err)
					res.json(err);
				} else {
					res.json(results);
				}
			})
		}



	}

})();