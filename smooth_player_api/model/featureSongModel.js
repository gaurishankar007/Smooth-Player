const mongoose = require("mongoose");

const featuredsongSchema = new mongoose.Schema(
  {
    featuredPlaylist: {
      type: mongoose.Schema.ObjectId,
      ref: "featuredPlaylist",
    },

    song: {
      type: mongoose.Schema.ObjectId,
      ref: "song",
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("featuredsong", featuredsongSchema);
