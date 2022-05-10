const multer = require("multer");

const storageNavigation = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, "../smooth_player_api/upload/image/user");
    },
    filename: function(req, file, cb) {
        cb(null, Date.now()+"_"+file.originalname);
    }
});


const filter = function(req, file, cb) {
    if(file.mimetype == "image/png" || file.mimetype=="image/jpeg") {
        cb(null, true);
    }
    else {
        cb(null, false);
    }
}

const upload = multer({
    storage: storageNavigation,
    fileFilter: filter
});

module.exports = upload;