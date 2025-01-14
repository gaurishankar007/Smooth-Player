const song = require("../model/songModel")
const mongoose = require("mongoose")

const url = "mongodb://localhost:27017/smooth_player_test"

beforeAll(async ()=> {
    mongoose.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
    })
})

afterAll(async ()=> {
    await mongoose.connection.close()
})

describe('song schema test', ()=> {

    // insert
    it('song insert testing', async ()=> {
        const newSong = {
            "title": "test",
            "album": "627b62e2a6487bbb7d0a85ed",
            "music_file": "song.mp3",
            "cover_image": "cover.jpg",
            
        } 
        const songData = await song.create(newSong)
        expect(songData.title).toEqual("test")
        expect(songData.album).toEqual(mongoose.Types.ObjectId("627b62e2a6487bbb7d0a85ed"))
        expect(songData.music_file).toEqual("song.mp3")
        expect(songData.cover_image).toEqual("cover.jpg")
    })

    // update
    it('song update testing', ()=> {
        return song.updateOne({_id: Object("62c6cf5c2112c264b34b613e")}, 
        {$set: {title: "New test"}})
        .then(()=> {
           return song.findOne({_id: Object("62c6cf5c2112c264b34b613e")})
            .then((songData)=> {                
                expect(songData.title).toEqual("New test")
            })
        })
    })    
})