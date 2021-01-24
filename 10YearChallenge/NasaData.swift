
import Foundation
struct NasaData:Codable
{
    var date : String
    var title : String
    var url :URL
    
    init?(json: [String: String]) {
        guard let title = json["title"],
            let urlString = json["url"],
            let photoDate = json["date"],
            let url = URL(string: urlString) else { return nil }
        
        self.title = title
        self.url = url
        self.date = photoDate
}
    
    struct NasaResults: Codable {
        var resultCount: Int
        var results: [NasaData]
    }

}
