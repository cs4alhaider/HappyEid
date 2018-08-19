//
//  ViewController.swift
//  Eid
//
//  Created by Abdullah Alhaider on 6/14/18.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //-------------------------------------------------------------------------------------------------//
    //------------------------------------------- Variables -------------------------------------------//
    //-------------------------------------------------------------------------------------------------//
    
    private var timer = Timer()
    
    private var shapeLayer: CAShapeLayer!
    private var pulsatingLayer: CAShapeLayer!
    
    private let myNameText: String = "YourNameHere"
    private let eidMessage: String = "يهنئك بعيد الفطر المبارك"
    private let eidMobark: String = "عيدك مبارك\nوكل عام وأنت بخير 🌹"
    
    private let myBlueColor: UIColor = UIColor(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
    private let myLightBlueColor: UIColor = UIColor(red: 0, green: 0.5898008943, blue: 1, alpha: 0.50)
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0.5898008943, blue: 1, alpha: 0.80)
        return view
    }()
    
    private let myNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let eidMessageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let eidMobarkLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.alpha = 0
        return label
    }()
    
    
    //-------------------------------------------------------------------------------------------------//
    //-------------------------------------------- Methods --------------------------------------------//
    //-------------------------------------------------------------------------------------------------//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addVerticalGradientLayer(topColor: .white, bottomColor: myBlueColor)
        scheduledTimerbegin()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: createCircleShapeLayer
    fileprivate func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
        // creating my track layer
        let layer = CAShapeLayer()
        // i need 2 pi (1 pi = 180 >> 1/2 a cercal) to get complete cercal to draw too the endAngle ..
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = lineWidth
        layer.fillColor = fillColor.cgColor
        // using kCALineCapRound to have a nicer track
        layer.lineCap = kCALineCapRound
        layer.position = view.center
        return layer
    }
    
    //MARK: customShapes
    fileprivate func customShapes(){
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear, fillColor: myLightBlueColor, lineWidth: 25)
        view.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        //
        let trackLayer = createCircleShapeLayer(strokeColor: myBlueColor, fillColor: .white, lineWidth: 20)
        view.layer.addSublayer(trackLayer)
        //
        shapeLayer = createCircleShapeLayer(strokeColor: .white, fillColor: .clear, lineWidth: 7)
        // transforming shapeLayer -90 degree
        shapeLayer.transform = CATransform3DMakeRotation( -CGFloat.pi/2 , 0 , 0 , 1 )
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        looping()
    }
    
    //MARK: looping
    fileprivate func looping() {
        print("Attempting to animate")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 4
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "someBasicAnimation")
        animatePulsatingLayer()
    }
    
    //MARK: animatePulsatingLayer
    fileprivate func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    //MARK: scheduledTimerbegin
    fileprivate func scheduledTimerbegin(){
        // scheduling timer to call start calling methods...
        timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.showBackView), userInfo: nil, repeats: false)
    }
    
    //MARK: showBackView
    @objc fileprivate func showBackView(){
        view.addSubview(backView)
        backView.alpha = 0
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        backView.widthAnchor.constraint(equalToConstant: 290).isActive = true
        backView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90).isActive = true
        
        backView.layer.masksToBounds = false
        backView.layer.shadowColor = UIColor.darkGray.cgColor
        backView.layer.shadowOpacity = 0.3
        backView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backView.layer.shadowRadius = 12
        backView.layer.cornerRadius = 10
        backView.layer.shouldRasterize = false
        UIView.animate(withDuration: 1.8) {
            self.backView.alpha = 1
        }
        timer = Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(self.showMyNameLabel), userInfo: nil, repeats: false)
    }
   
    //MARK: showMyNameLabel
    @objc fileprivate func showMyNameLabel() {
        
        view.addSubview(myNameLabel)
        myNameLabel.alpha = 0
        myNameLabel.text = myNameText
        myNameLabel.translatesAutoresizingMaskIntoConstraints = false
        myNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myNameLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        myNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        UIView.animate(withDuration: 1) {
            self.myNameLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        timer = Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(self.showEidMessageLabel), userInfo: nil, repeats: false)
    }
    
    //MARK: showEidMessageLabel
    @objc fileprivate func showEidMessageLabel(){
        view.addSubview(eidMessageLabel)
        eidMessageLabel.alpha = 0
        eidMessageLabel.text = eidMessage
        eidMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        eidMessageLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        eidMessageLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        eidMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eidMessageLabel.topAnchor.constraint(equalTo: myNameLabel.topAnchor, constant: 40).isActive = true
        UIView.animate(withDuration: 1) {
            self.eidMessageLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.showEidMobarkLabel), userInfo: nil, repeats: false)
    }
    
    //MARK: showEidMobarkLabel
    @objc fileprivate func showEidMobarkLabel(){
        customShapes()
        view.addSubview(eidMobarkLabel)
        eidMobarkLabel.text = eidMobark
        UIView.animate(withDuration: 5) {
            self.eidMobarkLabel.alpha = 1
        }
        eidMobarkLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 120)
        eidMobarkLabel.setLineSpacing(lineHeightMultiple: 1.5)
        eidMobarkLabel.textAlignment = .center
        eidMobarkLabel.center = view.center
    }
    
    
    
}// class


//-------------------------------------------------------------------------------------------------//
//------------------------------------------- Extensions ------------------------------------------//
//-------------------------------------------------------------------------------------------------//


extension UIView {
    func addVerticalGradientLayer(topColor:UIColor, bottomColor:UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            topColor.cgColor,
            bottomColor.cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}
