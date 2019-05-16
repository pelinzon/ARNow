import ARKit

class MainViewController: UIViewController {
  
  var currentIndex = 0
  var sceneView: ARSKView!
  let croppedImagesList: [String] = ["acrop", "bcrop", "ccrop", "dcrop", "ecrop", "gcrop", "hcrop"]
  let fullImagesList: [String] = ["a", "b", "c", "d", "e", "g", "h"]
  let issueTitleList: [String] = ["Children in the Military", "Lack of Peace", "Droughts", "Homeless Veterans", "War and Violence", "Extreme Poverty", "Crisis in Venezuela"]
  let locationList: [String] = ["Vietnam", "FOB Delhi, Afghanistan", "Dadaab (East Africa)", "New York, USA", "Unknown Desert", "Camp Lemonnier, Djibouti", "Caracas, Venezuela"]
  let issueDescriptionList: [String] = ["In some parts of the world, armies and terrorist organizations are still recruiting children in order to coercively fight for violent ideas and use deadly weapons.", "Some nations currently face the need of aid in order to maintain themselves due to serious violence concerns.", "Droughts still largely affect developing nations around the world, especially countries near East Africa.", "Veterans in the United States often lack the necessary financial and psychological support to stabilize themselves, which may leave them without a bed to sleep at night.", "War is still a big issue in the 21st century, and efforts to bring peace to Earth are more important than ever.", "Even though extreme poverty has been steadily declining in the past decades, it’s possible to increase that rate through your help.", "Lack of food and economic stability has led the people of Venezuela to go to the streets and protest against the authoritarian regime they live under."]
  let creditsList: [String] = ["[CC0 – Free Use]", "Lance Cpl. Kevin Jones [Free Use]", "Andy Hall/Oxfam [CC BY 2.0]", "David Shankbone [CC Alike 3.0]", "[CC0 – Free Use]", "Joshua Bruns [Free Use]", "CNBC"]
  let helpLinkList: [String] = ["https://www.child-soldiers.org/", "http://www.afghanrelief.org", "https://www.ngoaidmap.org/projects/2250", "https://www.va.gov/homeless/", "https://www.peacedirect.org/", "http://www.wer-us.org/", "https://www.instagram.com/cascosazulesve/"]
  
  @IBOutlet weak var issueLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  
    @IBAction func repositionImage(_ sender: Any) {
        begin()
    }
    
    @IBAction func showNextImage(_ sender: Any) {
        if currentIndex < croppedImagesList.count - 1 {
            currentIndex += 1
            begin()
        }
    }
    
    @IBAction func showPreviousImage(_ sender: Any) {
        if currentIndex > 0 {
            currentIndex -= 1
            begin()
        }
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    begin()
    sceneView.session.run(ARWorldTrackingConfiguration())
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    sceneView.session.pause()
  }
    
    func begin(){
        if let view = self.view as? ARSKView {
            sceneView = view
            sceneView!.delegate = self
            let scene = MainScene(size: view.bounds.size)
            scene.scaleMode = .resizeFill
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            view.presentScene(scene)
            issueLabel.text = issueTitleList[currentIndex]
            locationLabel.text = locationList[currentIndex]
        }
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let destinationVC = segue.destination as? InfoViewController {
      destinationVC.issueTitle = issueTitleList[currentIndex]
      destinationVC.fullImageName = fullImagesList[currentIndex]
      destinationVC.issueDescription = issueDescriptionList[currentIndex]
      destinationVC.credits = "Credits: " + creditsList[currentIndex]
      destinationVC.helpLink = helpLinkList[currentIndex]
    }
  }
  
  func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
    let image = SKSpriteNode(imageNamed: croppedImagesList[currentIndex])
    image.name = croppedImagesList[currentIndex]
    return image
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}

extension MainViewController: ARSKViewDelegate {
  func session(_ session: ARSession, didFailWithError error: Error) {
    print("Session failed.")
  }
  
  func sessionWasInterrupted(_ session: ARSession) {
    print("Session interrupted.")
  }
  
  func sessionInterruptionEnded(_ session: ARSession) {
    print("Session resumed.")
    sceneView.session.run(session.configuration!, options: [.resetTracking, .removeExistingAnchors])
  }
}
