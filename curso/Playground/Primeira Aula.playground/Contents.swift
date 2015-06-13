import Foundation

// Montando um modelo de dados

struct Identifiers {
    let trakt: Int
    let slug: String?
    let tvdb: Int?
    let imdb: String?
    let tvrage: Int?
}

struct ImagesURLS {
    let fullURL:NSURL
    let mediumURL:NSURL
    let thumbURL:NSURL
}

struct Show {
    let title: String
    let year: Int
    let ids: Identifiers
    let overview: String?
    let firstAired: NSDate?
    let runtime: Int?
    let certification: String?
    let network: String?
    let country: String?
    let updateAt: NSDate?
    let trailer: NSURL?
    let homepage: NSURL?
    let status: String?
    let rating: Float?
    let votes: Int?
    let language: String?
    let genres: [String]?
    let airedEpisodes: Int?
    let fanart: ImagesURLS?
    let poster: ImagesURLS?
    let logo: NSURL?
    let clearart: NSURL?
    let banner: NSURL?
    let thumb: NSURL?
    
}

/*var myShow: Show
myShow.title = "Show Teste"
myShow.year = 2015
myShow.ids = Identifiers(trakt: 10, slug: "caminho", tvdb: nil, imdb: nil, tvrage: nil)
myShow.overview  = "Sobre o show"*/

let myShow = Show(
    title: "Tilte Show Test",
    year: 2015,
    ids: Identifiers(trakt: 10, slug: "Slug Test", tvdb: nil, imdb: nil, tvrage: nil),
    overview: "About",
    firstAired: NSDate(),
    runtime: 10,
    certification: "Certification",
    network: "Network",
    country: "Country",
    updateAt: NSDate(),
    trailer: NSURL(string: "http://www.google.com"),
    homepage: NSURL(string: "http://www.google.com"),
    status: "Status",
    rating: 10.0,
    votes: 10,
    language: "Language",
    genres: "Genre",
    airedEpisodes: 10,
    fanart: ImagesURLS(
        fullURL: NSURL(string: "http://www.google.com/logo.jpg"),
        mediumURL: NSURL(string: "http://www.google.com/logo.jpg"),
        thumbURL: NSURL(string: "http://www.google.com/logo.jpg")),
    poster: ImagesURLS(
        fullURL: NSURL(string: "http://www.google.com/logo.jpg"),
        mediumURL: NSURL(string: "http://www.google.com/logo.jpg"),
        thumbURL: NSURL(string: "http://www.google.com/logo.jpg")),
    logo: NSURL(string: "http://www.google.com/logo.jpg"),
    clearart: NSURL(string: "http://www.google.com.br/clearart.jpg"),
    banner: NSURL(string: "http://www.google.com.br/banner.jpg"),
    thumb: NSURL(string: "http://www.google.com.br/thumb.jpg")
)











