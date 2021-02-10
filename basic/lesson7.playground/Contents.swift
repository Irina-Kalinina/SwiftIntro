import UIKit

// 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
// MARK: - музыкальный автомат

struct Music{
    var price: Int
    var song: SongName
}

struct SongName{
    let name: String
}

enum JukeBoxError: Error {
    case invalidSelection(String)
    case insufficientFunds(coinsNeedded: Int)
    
    var localizedDescription: String{
        switch self {
        case .invalidSelection(let name):
            return "Band \(name) is unavailable"
        case .insufficientFunds(coinsNeedded: let coinsNeedded):
            return "Not enough money, add \(coinsNeedded)"
        }
    }
}

class JukeBox{
    
    var musicAvailable = [
        "The Who": Music(price: 10, song: SongName(name: "Behind Blue Eyes")),
        "Led Zeppelin" : Music(price: 20, song: SongName(name: "Whole Lotta Love")),
        "The Rolling Stones" : Music(price: 25, song: SongName(name: "Paint It, Black")),
        "Pink Floyd" : Music(price: 15, song: SongName(name: "Comfortably Numb")),
        "Joy Division" : Music(price: 5, song: SongName(name: "Transmission"))
    ]
    
    var deposit: Int
    
    // shuffle play by artist
    private func findSong(bandName band: String) -> (song: SongName?, error: JukeBoxError?) {
        guard let someBand = musicAvailable[band] else {
            return (song: nil, error: JukeBoxError.invalidSelection(band))
        }
        guard someBand.price <= deposit else {
            return (song: nil, error: JukeBoxError.insufficientFunds(coinsNeedded: someBand.price - deposit))
        }
        
        deposit -= someBand.price
        print("The song \(someBand.song.name) is playing")
        return (song: someBand.song, error: nil)
    }
    
    func playSomething(band: String){
        let listenBand = findSong(bandName: band)
        if let _ = listenBand.0 {
            print("The remaining deposit is \(deposit)")
            } else if let error: JukeBoxError = listenBand.error {
                print("Error:", error.localizedDescription.description)
            }
        }
    
    func printBands () {
        print("Вы можете включить песню одной из следующих групп:", musicAvailable.keys, "\n")
    }
    
    init(deposit:Int){
        self.deposit = deposit
    }
}


var song1 = JukeBox(deposit: 45)
song1.printBands()
song1.playSomething(band: "Led Zeppelin")
song1.playSomething(band: "The Who")
song1.playSomething(band: "Queen")
print("-------------------")
var song2 = JukeBox(deposit: 5)
song2.playSomething(band: "Pink Floyd")
song2.playSomething(band: "Joy Division")
print("-------------------")


// 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.
// MARK: - Filmoteka

struct Movies{
    var name: String
    var ageRestriction: ageRestrictionList
    var country: countryList
    var rate: Int
    var price: Int
    
    enum ageRestrictionList {
        case G
        case PG
        case PG13
        case R
    }
    
    enum countryList {
        case RU
        case EN
    }
}

enum FilmotekaError: Error {
    case invalidSelection(String)
    case insufficientFunds(coinsNeedded: Int)
    
    var localizedDescription: String{
        switch self {
        case .invalidSelection(let title):
            return "Genre \(title) id unavailable"
        case .insufficientFunds(coinsNeedded: let coinsNeedded):
            return "Not enough money, add \(coinsNeedded)"
        }
    }
}

class Filmoteka {
    
    var moviesAvailable = [
        "Horror": Movies(name: "The Ring", ageRestriction: .PG13, country: .EN, rate: 7, price: 50),
        "Drama": Movies(name: "The Godfather", ageRestriction: .R, country: .EN, rate: 9, price: 200),
        "Action": Movies(name: "Inception", ageRestriction: .PG13, country: .EN, rate: 8, price: 150),
        "Comedy": Movies(name: "Ocean's 8", ageRestriction: .PG13, country: .EN, rate: 7, price: 100),
        "Cartoon": Movies(name: "Masha and the Bear", ageRestriction: .G, country: .RU, rate: 7, price: 100)
    ]
    
    var deposit: Int

    // pick a movie by genre
    private func pickGenre(someGenre genre: String) throws -> Movies {
        
        guard let item = moviesAvailable[genre] else {
            throw FilmotekaError.invalidSelection(genre)
        }
        guard item.price <= deposit else {
            throw FilmotekaError.insufficientFunds(coinsNeedded: item.price - deposit)
        }
        
        deposit -= item.price
        print("Film \(item.name) starts now")
        return item
    }
    
    func playMovie(genre: String ){
        do {
            let _ = try pickGenre(someGenre: genre)
            print("Enjoy your movie!")
        } catch let error as FilmotekaError {
            print("Error: \(error.localizedDescription)")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func printGenres () {
        print("Вы можете выбрать фильм одного из следующих жанров:", moviesAvailable.keys, "\n")
    }
    
    init(deposit:Int){
        self.deposit = deposit
    }
}

var movie1 = Filmoteka(deposit: 200)
movie1.printGenres()
movie1.playMovie(genre: "Action")
movie1.playMovie(genre: "Drama")
print("-------------------")
var movie2 = Filmoteka(deposit: 250)
movie2.playMovie(genre: "History")
movie2.playMovie(genre: "Comedy")
movie2.playMovie(genre: "Cartoon")
