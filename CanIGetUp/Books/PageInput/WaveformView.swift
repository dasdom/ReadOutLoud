//  Created by dasdom on 12.02.21.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit

class WaveformView: UIView {

  var values: [Float] = [] {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func draw(_ rect: CGRect) {
        
    let maxValue: CGFloat = 50
    let minValue: CGFloat = -46
//    if let max = values.max() {
//      maxValue = CGFloat(max) + 50
//    } else {
//      maxValue = 1
//    }
    
    let width = frame.width
    let height = frame.height
    let y0 = height/2.0

    let bezierPath = UIBezierPath()

    for (index, value) in values.enumerated() {
      let x = CGFloat(index) * width / 204.0
      let y = CGFloat(value) - minValue
      bezierPath.move(to: CGPoint(x: x, y: y0-y))
      bezierPath.addLine(to: CGPoint(x: x, y: y0+y))
    }
    
    UIColor.white.setStroke()
    bezierPath.lineWidth = 2
    bezierPath.stroke()
  }
}
