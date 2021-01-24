
import UIKit


class ViewController: UIViewController
{
    var nasa: NasaData!
    
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var now: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    //上傳圖片
    func updateUI() {
        now.text = nasa.date
        NasaController.shared.photoImage(url: nasa.url) { (image) in
            DispatchQueue.main.async {
                self.photoImage.image = image
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()

      
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
     
    }
    
    }
    
    
    
    
    
  
