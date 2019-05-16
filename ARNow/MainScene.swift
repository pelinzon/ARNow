import ARKit

class MainScene: SKScene {
  
  var isSceneReady = false
  var anchorList: [ARAnchor] = []
  var sceneView: ARSKView {
    return view as! ARSKView
  }

  private func readyUp() {
    guard let currentFrame = sceneView.session.currentFrame else { return }
    var translation = matrix_identity_float4x4
    translation.columns.3.z = -4
    let transform = currentFrame.camera.transform * translation
    let anchor = ARAnchor(transform: transform)
    
    for anchor in anchorList {
      sceneView.session.remove(anchor: anchor)
    }
    
    sceneView.session.add(anchor: anchor)
    anchorList.append(anchor)
    isSceneReady = true
  }
  
  override func update(_ currentTime: TimeInterval) {
    if !isSceneReady {
      readyUp()
    }
    
    guard let currentFrame = sceneView.session.currentFrame,
      let lightEstimate = currentFrame.lightEstimate else {
        return
    }
    let ambientIntensity = min(lightEstimate.ambientIntensity, 1000)
    let blendFactor = 1 - ambientIntensity / 1000
    for node in children {
      if let image = node as? SKSpriteNode {
        image.color = .black
        image.colorBlendFactor = blendFactor
      }
    }
  }
}
