var mongoose = require('mongoose');

var TaskSchema = new mongoose.Schema({
	objective: {type: String, required: [true, 'A task objective must be entered.']},
}, {timestamps: true});

mongoose.model('Task', TaskSchema);