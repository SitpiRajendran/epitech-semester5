const mongoose = require('mongoose');

const UserWidgetSchema = new mongoose.Schema({
    widgetname:{
        type: String,
        required: true
    },
    username:{
        type: String,
        required: true
    },
    position:{
        type: Number,
        required: true
    },
    param1:{
        type: String,
        required: false
    },
    param2:{
        type: String,
        required: false
    },
    param3:{
        type: String,
        required: false
    },
});

const UWidget = mongoose.model('UWidget', UserWidgetSchema);
/* const newWidget = new UWidget({
    "widgetname":"liveweather",
    "username":"sitpi",
    "param1":"1009",
});
newWidget.save().catch(err => {console.log(err)}); */

module.exports = UWidget;
