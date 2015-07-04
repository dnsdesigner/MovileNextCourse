//
//  OverlayView.swift
//  movile-up-ios
//
//  Created by Marcelo Fabri on 15/05/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

@IBDesignable public class OverlayView: UIView {
    
    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGradient()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setupGradient()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupGradient()
    }
    
    private func setupGradient() {
        let locations: [CGFloat] = [ 0.0, 0.15, 0.55, 0.75, 1 ]
        
        let colors = [
            UIColor(white: 0, alpha: 0.7).CGColor!,
            UIColor(white: 0, alpha: 0.5).CGColor!,
            UIColor(white: 0, alpha: 0.1).CGColor!,
            UIColor(white: 0, alpha: 0).CGColor!]
        
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPointZero
        
        setNeedsDisplay()
    }
    
    override public class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
}
