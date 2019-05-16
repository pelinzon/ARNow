import UIKit

class InfoViewController: UIViewController {

  var issueTitle: String?
  var fullImageName: String?
  var issueDescription: String?
  var credits: String?
  var helpLink: String?

    @IBOutlet weak var l_issueTitle: UILabel!
    @IBOutlet weak var l_issueDescription: UILabel!
    @IBOutlet weak var l_credits: UILabel!
    @IBOutlet weak var l_fullImage: UIImageView!
    @IBOutlet weak var l_helpButton: UIButton!
    
    @IBAction func helpButtonPress(_ sender: Any) {
      UIApplication.shared.open(URL(string: helpLink!)!, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
    infoView.layer.cornerRadius = 5
    infoView.layer.masksToBounds = true
    l_issueTitle.text = issueTitle
    l_issueDescription.text = issueDescription
    l_credits.text = credits
    l_fullImage.image = UIImage(named: fullImageName!)
  }

  @IBOutlet weak var infoView: UIView!
    
  @IBAction func closeInfoView(_ sender: Any){
    dismiss(animated: true, completion: nil)
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}
