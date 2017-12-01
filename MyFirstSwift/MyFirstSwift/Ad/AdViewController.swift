//
//  AdViewController.swift
//  MyFirstSwift
//
//  Created by mobiletek on 2017/11/20.
//  Copyright © 2017年 ZY. All rights reserved.
//

import UIKit

enum SkipButtonType {
    case none                   // 无跳过按钮
    case timer                  // 跳过+倒计时
    case circle                 // 圆形跳过
}
enum SkipButtonPosition {
    case rightTop               // 屏幕右上角
    case rightBottom            // 屏幕右下角
    case rightAdViewBottom      // 广告图右下角
}

enum TransitionType {
    case none
    case rippleEffect           // 波纹
    case fade                   // 交叉淡化
    case flipFromTop            // 上下翻转
    case filpFromBottom
    case filpFromLeft           // 左右翻转
    case filpFromRight
}

class AdViewController: UIViewController {

    // 默认3s
    fileprivate var defaultTime = 3
    
    // 广告图距底部距离
    fileprivate var adViewBottomDistance: CGFloat = 100
    
    // 变换类型
    fileprivate var transitionType: TransitionType = .fade
    
    // 跳过按钮位置
    fileprivate var skipBtnPosition: SkipButtonPosition = .rightTop
    
    // 广告时间
    fileprivate var adDuration: Int = 0
    
    // 默认定时器
    fileprivate var originalTimer: DispatchSourceTimer?
    
    // 图片显示定时器
    fileprivate var dataTimer: DispatchSourceTimer?
    
    // 图片点击闭包
    fileprivate var adImageViewClick: (() -> ())?
    
    // 图片倒计时完成闭包
    fileprivate var completion: (() -> ())?
    
    // 动画layer
    fileprivate var animationLayer: CAShapeLayer?
    
    // 跳过按钮类型
    fileprivate var skipBtnType: SkipButtonType = SkipButtonType.timer {
        didSet {
            let btnWidth: CGFloat = 60
            let btnHeight: CGFloat = 30
            var y: CGFloat = 0
            switch skipBtnPosition {
                case .rightBottom:
                    y = UIScreen.main.bounds.size.height - 50
                case .rightAdViewBottom:
                    y = UIScreen.main.bounds.size.height - adViewBottomDistance - 50
                default:
                    y = 50
            }
            let timeRect = CGRect(x: UIScreen.main.bounds.size.width - 70, y: y, width: btnWidth, height: btnHeight);
            let circleRect = CGRect(x: UIScreen.main.bounds.size.width - 50, y: y, width: btnWidth, height: btnHeight)
            skipBtn.frame = skipBtnType == .timer ? timeRect : circleRect
            skipBtn.titleLabel?.font = UIFont.systemFont(ofSize: skipBtnType == .timer ? 13.5 : 12)
            skipBtn.setTitle(skipBtnType == .timer ? "\(adDuration)s跳过" : "跳过", for: .normal)
        }
    }
    
    // 启动页
    fileprivate lazy var launchImageView: UIImageView = {
        let imageView = UIImageView.init(frame: UIScreen.main.bounds)
        imageView.image = self.getLaunchImage()
        return imageView
    }()
    
    // 广告图
    fileprivate lazy var launchAdImageView: UIImageView = {
        let adImageRect = CGRect(x: 0,y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - adViewBottomDistance)
        let adImageView = UIImageView.init(frame: adImageRect)
        adImageView.isUserInteractionEnabled = true
        adImageView.alpha = 0.2
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(launchAdTapAction(sender:)))
        adImageView.addGestureRecognizer(tap)
        return adImageView
    }()
    
    // 跳过按钮
    fileprivate lazy var skipBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(skipBtnClick), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func launchAdTapAction(sender: UITapGestureRecognizer) {
        dataTimer?.cancel()
        launchAdRemove {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                if self.adImageViewClick != nil {
                    self.adImageViewClick!()
                }
            })
        }
    }
    @objc fileprivate func skipBtnClick() {
        dataTimer?.cancel()
        launchAdRemove(completion: nil)
    }
    
    // 关闭广告
    fileprivate func launchAdRemove(completion: (() -> ())?) {
        if self.originalTimer?.isCancelled == false {
            self.originalTimer?.cancel()
        }
        if self.dataTimer?.isCancelled == false {
            self.dataTimer?.cancel()
        }
        
        let trans = CATransition()
        trans.duration = 0.5
        switch transitionType {
            case .rippleEffect:
                trans.type = "rippleEffect"
            case .filpFromLeft:
                trans.type = "oglFlip"
                trans.subtype = kCATransitionFromLeft
            case .filpFromRight:
                trans.type = "oglFlip"
                trans.subtype = kCATransitionFromRight
            case .flipFromTop:
                trans.type = "oglFlip"
                trans.subtype = kCATransitionFromRight
            case .filpFromBottom:
                trans.type = "oglFlip"
                trans.subtype = kCATransitionFromBottom
            default:
                trans.type = "fade"
        }
        UIApplication.shared.keyWindow?.layer.add(trans, forKey: nil)
        
        if self.completion != nil {
            self.completion!()
            if completion != nil {
                completion!()
            }
        }
    }
    
    // 初始化  设置默认显示时间defaultDuration,如果不设置，默认3s
    convenience init(defaultDuration: Int = 3, completion: (() -> ())?) {
        self.init(nibName: nil, bundle: nil)
        if defaultDuration >= 1 {
            self.defaultTime = defaultDuration
        }
        self.completion = completion
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(launchImageView)
        dataTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        startTimer()
    }

    deinit {
        printLog("bye")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - 参数设置
extension AdViewController {
    /* 设置广告参数 - Parameters:
     **   - url: 路径
     **   - adDuration:             显示时间
     **   - skipBtnType:            跳过按钮类型，默认 倒计时+跳过
     **   - skipBtnPosition:        跳过按钮位置，默认右上角
     **   - adViewBottomDistance:   图片距底部的距离，默认100
     **   - transitionType:         过渡的类型，默认没有
     **   - adImageViewClick:       点击广告回调
     **   - completion:             完成回调
     */
    func setAdParams(url: String, adDuration: Int = 3, skipBtnType: SkipButtonType = .timer, skipBtnPosition: SkipButtonPosition = .rightTop, adViewBottomDistance: CGFloat = 100, transitionType: TransitionType = .none, adImageViewClick: (() -> ())?) {
        self.adDuration = adDuration
        self.skipBtnType = skipBtnType
        self.skipBtnPosition = skipBtnPosition
        self.adViewBottomDistance = adViewBottomDistance
        self.transitionType = transitionType
        if adDuration < 1 {
            self.adDuration = 1
        }
        if url != "" {
            self.view.addSubview(launchAdImageView)
            self.launchAdImageView.setImage(url: url, completion: {
                // 如果带缓存，并且需要改变按钮状态
                self.skipBtn.removeFromSuperview()
                if self.animationLayer != nil {
                    self.animationLayer?.removeFromSuperlayer()
                    self.animationLayer = nil
                }
                if skipBtnType != .none {
                    self.view.addSubview(self.skipBtn)
                    if self.skipBtnType == .circle {
                        self.addLayer(view: self.skipBtn)
                    }
                }
                self.adStartTimer()
                UIView.animate(withDuration: 0.8, animations: {
                    self.launchAdImageView.alpha = 1
                })
            })
        }
        self.adImageViewClick = adImageViewClick
    }
    
    // 添加动画
    fileprivate func addLayer(view: UIView) {
        let bezierPath = UIBezierPath.init(ovalIn: view.bounds)
        animationLayer = CAShapeLayer()
        animationLayer?.path = bezierPath.cgPath
        animationLayer?.lineWidth = 1
        animationLayer?.strokeColor = UIColor.red.cgColor
        animationLayer?.fillColor = UIColor.clear.cgColor
        let animation = CABasicAnimation.init(keyPath: "strokeStart")
        animation.duration = Double(adDuration)
        animation.fromValue = 0
        animation.toValue = 1
        animationLayer?.add(animation, forKey: nil)
        view.layer.addSublayer(animationLayer!)
    }
}

/* MARK: - GCD定时器
 ** APP启动后开始默认定时器，默认3s
 ** 3s内若网络图片加载完成，默认定时器关闭，开启图片倒计时
 ** 3s内若图片加载未完成，执行completion闭包
 */
extension AdViewController {
    // 默认定时器
    fileprivate func startTimer() {
        originalTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        originalTimer?.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.milliseconds(self.defaultTime))
        originalTimer?.setEventHandler(handler: {
            if self.defaultTime == 0 {
                self.launchAdRemove(completion: nil)
            }
            self.defaultTime -= 1
        })
        originalTimer?.resume()
    }
    
    // 图片倒计时
    fileprivate func adStartTimer() {
        if self.originalTimer?.isCancelled == false {
            self.originalTimer?.cancel()
        }
        dataTimer?.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.milliseconds(self.adDuration))
        dataTimer?.setEventHandler(handler: {
            self.skipBtn.setTitle(self.skipBtnType == .timer ? "\(self.adDuration)s跳过" : "跳过", for: .normal)
            if self.adDuration == 0 {
                self.launchAdRemove(completion: nil)
            }
            self.adDuration -= 1
        })
        dataTimer?.resume()
    }
}

// MARK: - 状态栏相关
extension AdViewController {
    // 状态栏显示、颜色与General -> Deployment Info中设置一致
    override var prefersStatusBarHidden: Bool {
        return Bundle.main.infoDictionary?["UIStatusBarHidden"] as! Bool
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        let str = Bundle.main.infoDictionary?["UIStatusBarStyle"] as! String
        return str.contains("Default") ? .default : .lightContent
    }
}

// MARK: - 获取启动页
extension AdViewController {
    fileprivate func getLaunchImage() -> UIImage {
        if assetsLaunchImage() != nil || storyboardLaunchImage() != nil {
            return assetsLaunchImage() != nil ? assetsLaunchImage()! : storyboardLaunchImage()!
        }
        return UIImage()
    }
    
    // 获取Assets里LaunchImage
    fileprivate func assetsLaunchImage() -> UIImage? {
        let size = UIScreen.main.bounds.size
        let orientation = "Portrait" //横屏 "Landscape"
        guard let launchImages = Bundle.main.infoDictionary?["UILaunchImages"] as? [[String: Any]] else {
            return nil
        }
        for dic in launchImages {
            let imageSize = CGSizeFromString(dic["UILaunchImageSize"] as! String)
            if __CGSizeEqualToSize(imageSize, size) && orientation == (dic["UILaunchImageOrientation"] as! String) {
                let launchImageName = dic["UILaunchImageName"] as! String
                let image = UIImage.init(named: launchImageName)
                return image
            }
        }
        return nil
    }
    
    // 获取LaunchScreen.Storyboard
    fileprivate func storyboardLaunchImage() -> UIImage? {
        guard let storyboardLaunchName = Bundle.main.infoDictionary?["UILaunchStoryboardName"] as? String,
            let launchViewController = UIStoryboard.init(name: storyboardLaunchName, bundle: nil).instantiateInitialViewController() else {
                return nil
        }
        let view = launchViewController.view
        view?.frame = UIScreen.main.bounds
        let image = viewConvertImage(view: view!)
        return image
    }

    // view转换图片
    fileprivate func viewConvertImage(view: UIView) -> UIImage {
        let size = view.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

// MARK: - Log日志
func printLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line){
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}
