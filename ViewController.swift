import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var parallax: ParallaxControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func sliderValueChanged(_ sender: Any) {
        parallax.value = Double(slider.value)
    }
}
