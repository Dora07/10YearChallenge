
import UIKit


class ViewController: UIViewController
{
    

    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var now: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var ImageTitle: UILabel!
    
    // 建立型別為[Photo]的物件
    var photos = [Photo]()
    var imageURL: URL!
    var years = [2010-01-01, 2011-01-01, 2012-01-01, 2013-01-01, 2014-01-01, 2015-01-01, 2016-01-01, 2017-01-01, 2018-01-01, 2019-01-01, 2020-01-01,2021-01-01]
    var timer: Timer?
    
    
    
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPhotos()
    
      
    }
    
    //時間date picker
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func datePickerAction(_ sender: UIDatePicker)
    {
        //設定樣式
        datePicker.preferredDatePickerStyle = .wheels
        //設定只選擇日期
        datePicker.datePickerMode = .date
        //設定範圍最高是今天,最低時間是2011/01/01
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let dateString = "2011/01/01"
        let minday = dateFormatter.date(from: dateString)
        datePicker.maximumDate = today
        datePicker.minimumDate = minday
}
    //Slider
    @IBOutlet weak var DateSlider: UISlider!

    @IBAction func SliderChanged(_ sender: UISlider)
    {
        min.text = (String(Int(sender.minimumValue)))
        max.text = (String(Int(sender.maximumValue)))
     
       
    
    }
    //slider & picker
    @IBAction func sliderPicker(_ sender: UISlider)
    {   //取得slider年份
        let year = sender.value
        // 設定與datePicker連動
        // 建立DateComponents物件
        var dateComponents = DateComponents()
        // 取得目前日曆物件(用於計算時間)
        dateComponents.calendar = Calendar.current
        // 存取當前選到的年份
        dateComponents.year = Int(year)
        // 將組成之日期傳給datepicker
        datePicker.date = dateComponents.date!
        
        // 同步label年份
       now.text = (String(Int(sender.value)))
        
        // update imageView
       
        let index = Int(year) - 2010
        showImage(index)
        
  
     
    }
    
    
    // 利用API送出指定url獲取Data後解析
    func fetchData() {
        // 抓取2010-2020年間的Data
        for year in years {
            let url = "https://api.nasa.gov/planetary/apod?api_key=4zyFSDdTOuPXrq2L5RkjbKMElXdsFny0LGmGjXPd&date= \(years)"
            let index = (year - 2010)
            if let url = URL(string: url) {
                    // 抓取Data
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        // 解析JSON
                        if let data = data, let searchData = try? JSONDecoder().decode(SearchData.self, from: data) {
                            print("index:\(index)", year, searchData.photos.photo)
                            self.photos.remove(at: index)
                            self.photos.insert(contentsOf: searchData.photos.photo, at: index)
                            self.showImage(0)
                        }
                        print(self.photos)
                    }
                    // 啟動任務
                    task.resume()
            }
        }
    }
    
    // 利用回傳的Data重組url後download image
    func downloadImage(url: URL, handler: @escaping (UIImage?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                handler(image)
            } else {
                handler(nil)
            }
        }
        task.resume()
    }
    
    func showImage(_ index: Int) {
        let photo = photos[index]
        imageURL = photo.url
        downloadImage(url: imageURL) { (image) in
            if self.imageURL == photo.url, let image = image {
                DispatchQueue.main.async {
                    self.photoImage.image = image
                }
            }
        }
    }
    
 func initPhotos() {
    photos = [Photo](repeating: Photo( date: "", title: ""), count: years.count)
        print(photos)
   }
   
   
 
    }
   
  
    
    
  
    
    
  

