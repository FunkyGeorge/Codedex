var mongoose = require('mongoose');

var CoderSchema = new mongoose.Schema({
	name: {type: String},
	status: {type: String},
	level: {type: String},
	specialty: {type: String}
}, {timestamps: true});

mongoose.model('Coder', CoderSchema);