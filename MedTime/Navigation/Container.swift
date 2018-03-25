//
//  Container.swift
//  HackNYU
//
//  Created by alden lamp on 3/23/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//
import UIKit

enum SlideState{
    case mainVC
    case leftPanelExpanded
}

var userData: MainDataClass!

struct Notifications{
    static public let logOut = NSNotification.Name(rawValue: NavigationNotifications.logOut.rawValue)
    static public let willFinishLogIn = NSNotification.Name(rawValue: "Log In Complete")
    static public let userDataDidLoad = NSNotification.Name(rawValue: "User Data Did Load")
    static public let shouldToggleMenu = NSNotification.Name(rawValue: NavigationNotifications.toggleMenu.rawValue)
    static public let shouldSwitchToHome = NSNotification.Name(rawValue: NavigationNotifications.home.rawValue)
    static public let shouldSwitchToSettings = NSNotification.Name(NavigationNotifications.settings.rawValue)
    static public let shouldSwitchToMedicine = NSNotification.Name(rawValue: NavigationNotifications.medicine.rawValue)
    static public let shouldSwitchToDetails = NSNotification.Name(rawValue: NavigationNotifications.details.rawValue)
    
    static public let phoneDroppedDismissed  = NSNotification.Name(rawValue: "Iphone did Dropped Dismissed")
    static public let phoneDidDrop = NSNotification.Name(rawValue: "Iphone did Dropped")
    
    enum NavigationNotifications: String {
        case toggleMenu = "toggleMenuNotifictaion"
        case home = "Home"
        case medicine = "Medicine"
        case logOut = "Log Out"
        case logtIn = "Log In"
        case details = "Details"
        case settings = "Settings"
    }

    static let notificationToViewController: [String: UIViewController.Type] = ["Home": HomeViewController.self, "Log Out" : LogIn.self, "Settings" : SettingsViewController.self, "Medicine" : MedicineViewController.self, "Details" : DetailsViewController.self]
    
}


class Container: UIViewController {
    var activeNavigationController: MainNavigationController!
    var currentState: SlideState = .mainVC
    var allowSlide = true
    
    var leftPanelController = SideBar()
    let leftPanelWidth: CGFloat = 240
    var containerOverlay = UIButton()
    
    var storedVC = UIViewController()
    
    let motionSensor = CoreMotionSensor()
    
    
    //MARK: - Motion Sensors
    
    func watchDrops(){
        NotificationCenter.default.addObserver(forName: Notifications.phoneDidDrop, object: nil, queue: nil) { [weak self] (notification) in
            self?.motionSensor.isTrackingMotion = false
            self?.alert(title: "Phone Did Drop", message: "This phone sensed a strong movement", buttonTitle: "Okay", completion: {
                self?.motionSensor.isTrackingMotion = true
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userData = MainDataClass()
        
        motionSensor.isTrackingMotion = true
        
        activeNavigationController = MainNavigationController()
        view.addSubview(activeNavigationController.view)
        addChildViewController(activeNavigationController)
        
        activeNavigationController.didMove(toParentViewController: self)
//
//        self.allowSlide = false
//        self.activeNavigationController.navigationBar.isHidden = true
//        if self.currentState == .leftPanelExpanded{
//            self.toggleMenu()
//        }
//        userData = nil
        
        activeNavigationController.switchViewTo(HomeViewController())
//        activeNavigationController.switchViewTo(LogIn())
        
        containerOverlay = UIButton(frame: self.view.frame)
        containerOverlay.backgroundColor = UIColor.black
        containerOverlay.isUserInteractionEnabled = false
        containerOverlay.layer.opacity = 0.0
        containerOverlay.addTarget(self, action: #selector(Container.overlayClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(containerOverlay)
        
        self.addLeftPanelViewController()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(Container.handlePanGesture(_:)))
        panGestureRecognizer.delegate = self
        activeNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        let panelPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(Container.handlePanGesture(_:)))
        panelPanGestureRecognizer.delegate = self
        leftPanelController.view.addGestureRecognizer(panelPanGestureRecognizer)
        let tableViewPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(Container.handlePanGesture(_:)))
        tableViewPanGestureRecognizer.delegate = self
        leftPanelController.view.addGestureRecognizer(tableViewPanGestureRecognizer)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: Notifications.shouldToggleMenu, object: nil, queue: nil, using: { (notification) in
            self.toggleMenu()
        })
        
        NotificationCenter.default.addObserver(forName: Notifications.logOut, object: nil, queue: nil) { (notification) in
            
            self.activeNavigationController.switchViewTo(UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LogIn"))
            self.allowSlide = false
            self.activeNavigationController.navigationBar.isHidden = true
            if self.currentState == .leftPanelExpanded{
                self.toggleMenu()
            }
            userData = nil
            //DISABLE TOGGLE MENUE AND NAV BAR
        }
        NotificationCenter.default.addObserver(forName: Notifications.willFinishLogIn, object: nil, queue: nil) { (notification) in
            self.allowSlide = true
            self.activeNavigationController.navigationBar.isHidden = false
            self.activeNavigationController.switchViewTo(HomeViewController())
            userData = MainDataClass()
        }
        
        setUpPhoneDropObserver()
        
    }
    
    func setUpPhoneDropObserver(){
        NotificationCenter.default.addObserver(forName: Notifications.phoneDidDrop, object: nil, queue: nil) { [weak self] (notification) in
            if Settings.allowsMotionSensing{
                self?.activeNavigationController.navigationBar.isHidden = true
                let vc = TimerViewController()
                vc.totalTime = Settings.timeForMotionSensing
//                if let stVc = self?.activeNavigationController.viewControllers.first{
//                    self?.storedVC = stVc
//                }
                self?.activeNavigationController.switchViewTo(vc)
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notifications.phoneDroppedDismissed, object: nil, queue: nil) { [weak self] (notification) in
            self?.activeNavigationController.navigationBar.isHidden = false
//            if let vc = self?.storedVC{
//                self?.activeNavigationController.switchViewTo(vc)
//            }else{
                self?.activeNavigationController.switchViewTo(HomeViewController())
//            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //TODO: - Determine if the user Is logged in or not
        
        
//        if (callSetUpSideBar){
//            if FIRAuth.auth()?.currentUser == nil{
//                NotificationCenter.default.post(Notification(name: ReturnToLoginNotificationName, object: self))
//            }else{
//                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "setUpUserAttributesSideBar")))
//            }
//            callSetUpSideBar = false
//        }
    }
    
    
    @objc func overlayClicked(sender: UIButton){
        animateSidePanel(expand: false)
    }
    
    func toggleMenu() {
        if currentState == .mainVC{
            animateSidePanel(expand: true)
        }else{
            animateSidePanel(expand: false)
        }
    }
    
    let overlayFullOpacity:CGFloat = 0.5
    let fullShadowOpacity:Float = 0.7
    let sidePanelAnimationDuration = 0.3
    func animateSidePanel(expand:Bool){
        if expand{
            UIView.animate(withDuration: sidePanelAnimationDuration, delay: 0.0, options: .curveEaseOut, animations: {
                self.leftPanelController.view.frame = CGRect(x:0, y: 0, width: self.leftPanelController.view.frame.width, height: self.leftPanelController.view.frame.height)
                self.leftPanelController.view.layer.shadowOpacity = self.fullShadowOpacity
                self.containerOverlay.layer.opacity = Float(self.overlayFullOpacity)
                
            }, completion: nil)
            currentState = .leftPanelExpanded
            containerOverlay.isUserInteractionEnabled = true
        }else{
            UIView.animate(withDuration: sidePanelAnimationDuration, delay: 0.0, options: .curveEaseOut, animations: {
                self.leftPanelController.view.frame = CGRect(x: -self.leftPanelController.view.frame.width, y: 0, width: self.leftPanelController.view.frame.width, height: self.leftPanelController.view.frame.height)
                self.leftPanelController.view.layer.shadowOpacity = 0.0
                self.containerOverlay.layer.opacity = 0.0
            }, completion: nil)
            currentState = .mainVC
            containerOverlay.isUserInteractionEnabled = false
        }
    }
    
    func addLeftPanelViewController() {
        //        leftPanelController = SideBar()//UIStoryboard(name: "Navigation", bundle: Bundle.main).instantiateViewController(withIdentifier: "sideBar") as! SideBar
        leftPanelController.view.frame = CGRect(x: -leftPanelWidth, y: 0, width:leftPanelWidth, height: self.view.frame.height)
        view.addSubview(leftPanelController.view)
        leftPanelController.didMove(toParentViewController: self)
        leftPanelController.view.layoutIfNeeded()
        
    }
    
}


extension Container: UIGestureRecognizerDelegate{
    //MARK: - Gesture recognizer
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer){
        if allowSlide{
            switch recognizer.state {
//            case .began:
                
//                print("Began sliding VC")
            case .changed:
                let translation = recognizer.translation(in: view).x
                if translation + leftPanelController.view.frame.origin.x < 0 && translation + leftPanelController.view.frame.origin.x > -leftPanelController.view.frame.width{
                    leftPanelController.view?.center.x = leftPanelController.view!.center.x + translation
                }
                containerOverlay.layer.opacity = Float((leftPanelController.view.frame.origin.x + leftPanelController.view.frame.width) / leftPanelController.view.frame.width * overlayFullOpacity)
                leftPanelController.view.layer.shadowOpacity = Float(Float(leftPanelController.view.frame.origin.x + leftPanelController.view.frame.width) / Float(leftPanelController.view.frame.width) * fullShadowOpacity)
                recognizer.setTranslation(CGPoint.zero, in: view)
            case .ended:
                if leftPanelController.view.center.x > 0{
                    if recognizer.velocity(in: view).x < -100{
                        animateSidePanel(expand: false)
                    }else{
                        animateSidePanel(expand: true)
                    }
                }else{
                    animateSidePanel(expand: false)
                }
            default:
                break
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if currentState != .mainVC {
            return true
        }
        if touch.location(in: self.view).x < self.view.frame.width / 3{
            return true
        }else {
            return false
        }
    }
}
