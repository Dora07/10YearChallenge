
import Foundation

struct Photo: Decodable {
    let date: String
    let title: String
    var url: URL {
        return URL(string: "https://apod.nasa.gov/apod/image/2101/SouthernCross_Slovinsky_960.jpg")!
    }
   
}

struct PhotoData: Decodable {
    let photo: [Photo]
}

struct SearchData: Decodable {
    let photos: PhotoData
}
