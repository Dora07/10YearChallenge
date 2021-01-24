import UIKit

class NasaController {
    
    static let shared = NasaController()
    
    func photoImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    var nasaArray = [NasaData]()
    
    func fetchSongs(completion: @escaping ([NasaData]?) -> Void) {
        if let urlStr = "https://api.nasa.gov/planetary/apod?api_key=KbC3LNS8QLTk1KaOjWBDT6xvb3s2R8i3a8ZPYSEL&start_date=2010-01-01&end_date=2021-01-24".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                if let data = data, let resultArray = (try? JSONSerialization.jsonObject(with: data,options: [])) as? [[String: Any]] {
                    print(resultArray)
                    for nasaData in resultArray {
                        if let nasa = NasaData(json: nasaData as! [String : String]) {
                            self.nasaArray.append(nasa)
                        }
                    }
                    completion(self.nasaArray)
                }
            }
            task.resume()
        }
    }
}


