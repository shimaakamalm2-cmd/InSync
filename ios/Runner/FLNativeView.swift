//
//  FLNativeView.swift
//  Runner
//
//  Created by Ziad on 15/10/2026.
//

import UIKit

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        _view = UIView()
        
        super.init()
        // iOS views can be created here
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }

    var effectsView = UIVisualEffectView(frame: CGRect(x: 10, y: 2, width: 100, height: 100))
    
    func createNativeView(view _view: UIView) {
        
        let testLabel = UILabel(frame: CGRect(x: 40, y: 40, width: 180, height: 48))
        testLabel.text = "Hello, UIKit!"
        testLabel.shadowColor = .black
        testLabel.textColor = .black
        testLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        testLabel.backgroundColor = .clear
        _view.addSubview(testLabel)
        
        let shape = CAShapeLayer()
        shape.path = CGPath(roundedRect: CGRect(x: 0, y: 0, width: 180, height: 180), cornerWidth: 35, cornerHeight: 35, transform: nil)
        shape.fillColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        _ = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        effectsView.effect = UIGlassEffect(style: .clear)
        effectsView.cornerConfiguration = .capsule()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panView(pan:)))
        effectsView.addGestureRecognizer(pan)
        
        _view.addSubview(effectsView)
        
        let tabBar = UITabBar(frame: _view.bounds)
        tabBar.bounds = _view.bounds
        tabBar.items = [UITabBarItem(title: "Hello", image: .add, tag: 0)]
        
        _view.addSubview(tabBar)
        
    }
    
    var previousPanLocation: CGPoint? = nil
    
    @objc func panView(pan: UIPanGestureRecognizer) {
        
        if (pan.state == .possible) {
            previousPanLocation = pan.location(in: nil)
        }
        
        if let safePrevPanLocation = previousPanLocation {
            effectsView.frame = effectsView.frame.offsetBy(
                dx: pan.location(in: nil).x - safePrevPanLocation.x,
                dy: 0)
//            effectsView.center.x += (pan.location(in: nil).x - safePrevPanLocation.x)
//            effectsView.center.y += (pan.location(in: nil).y - safePrevPanLocation.y)
        }
        previousPanLocation = pan.location(in: _view)
        
        if (pan.state == .ended) {
            previousPanLocation = nil
        }
    
    }
}
