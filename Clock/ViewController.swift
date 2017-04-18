//
//  ViewController.swift
//  Clock
//
//  Created by 黄启明 on 2017/4/11.
//  Copyright © 2017年 黄启明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var hourHandView: UIView = {
        let hourHandView = UIView()
        hourHandView.backgroundColor = UIColor.gray
        hourHandView.bounds = CGRect(x: 0, y: 0, width: 2.5, height: 40)
        hourHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        return hourHandView
    }()
    
    lazy var minuteHandView: UIView = {
        let minuteHandView = UIView()
        minuteHandView.backgroundColor = UIColor.gray
        minuteHandView.bounds = CGRect(x: 0, y: 0, width: 2, height: 60)
        minuteHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        return minuteHandView
    }()
    
    lazy var secondHandView: UIView = {
        let secondHandView = UIView()
        secondHandView.backgroundColor = UIColor.gray
        secondHandView.bounds = CGRect(x: 0, y: 0, width: 1.5, height: 80)
        secondHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        return secondHandView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let clockImageView = UIImageView(image: UIImage(named: "Clock"))
        
        clockImageView.bounds = CGRect(x: 0, y: 0, width: 196, height: 196)
        clockImageView.center = view.center
        view.addSubview(clockImageView)
        
//        let clockLayer = CALayer()
//        clockLayer.bounds = CGRect(x: 0, y: 0, width: 196, height: 196)
//        clockLayer.position = view.center
//        clockLayer.contents = UIImage(named: "Clock")?.cgImage
//        view.layer.addSublayer(clockLayer)
        
        hourHandView.center = view.center
        view.addSubview(hourHandView)
        
        minuteHandView.center = view.center
        view.addSubview(minuteHandView)
        
        secondHandView.center = view.center
        view.addSubview(secondHandView)
        
        let link = CADisplayLink(target: self, selector: #selector(clockRunning))
        link.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func clockRunning() {
        let tZone = NSTimeZone.local
        
        var calendar = Calendar.current
        
        let currentDate = Date()
        
        calendar.timeZone = tZone
        
        let currentTime = calendar.dateComponents([Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second], from: currentDate)
        
        let secondAngle = Double(currentTime.second!) * 2.0 * Double.pi / 60
        secondHandView.transform = CGAffineTransform(rotationAngle: CGFloat(secondAngle))
        
        let minuteAngle = Double(currentTime.minute!) * 2.0 * Double.pi / 60 + Double(currentTime.second!) / 60 * 2.0 * Double.pi / 60
        minuteHandView.transform = CGAffineTransform(rotationAngle: CGFloat(minuteAngle))
        
        let hourAngle = Double(currentTime.hour!) * 2.0 * Double.pi / 12 + Double(currentTime.minute!) / 60 * 2.0 * Double.pi / 12
        hourHandView.transform = CGAffineTransform(rotationAngle: CGFloat(hourAngle))
    }

}

