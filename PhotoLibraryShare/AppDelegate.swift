//
//  AppDelegate.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 27.09.2020.
//

import UIKit
// ПОСЛЕ СОЗДАНИЯ МОДЕЛИ COREDATA И ОПРЕДЕЛЕНИЯ ИЗОБРАЖЕНИЯ КАК DATA BINARY - ПО ПРОЕКТУ ПРИДЕТСЯ ИСПРАВЛЯТЬ ОШИБКИ. УДАЛЯТЬ СОЗДАННЫЙ ФАЙЛ СО СТРУКТУТОРОЙ НАШИХ СВОЙСТВ. ИЗОБРАЖЕНИЯ, КОТОРЫЕ ИМЕЕЮТ ВИД UIImage(named: namefuture[indexPath.row].images) НУЖНО ПРИВОДИТЬ К ТАКОМУ ВИДУ: UIImage(data: namefuture[indexPath.row].images! as Data), ТАК КАК НАШИ ИЗОБРАЖЕНИЯ ИМЕЮТ ФОРМАТ BINARY DATA

//@main
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // MARK: - VAR, LET, ARRAY CONSTANT
    lazy var coreDataStack = CoreDataStack()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        // MARK: - TAB BAR APPEARENCE
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().barTintColor = .black
//        UITabBar.appearance().alpha = 0.5
        //        UITabBar.appearance().selectionIndicatorImage = UIImage(named: "")
//        let blurEffect = UIBlurEffect(style: .light) // создаем константу блюреффект
//        let blurEffectView =  UIVisualEffectView(effect: blurEffect) // создаем еще одну конснту где прописываем наш созданный блюрэффект
//        blurEffectView.frame =  // указываем фрейм
//        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth] // закрепляем наш блюр эффект Ю чтоб во всех ориентациях было одинаково
//        self.view.insertSubview(blurEffectView, at: 1) // добавляем блюр на наш вью
        
        
        // MARK: - NAVIGATION BAR APPEARENCE
        UINavigationBar.appearance().barTintColor = .white // appearance - это внешний вид! изменяем цвет навбара на зеленный
        UINavigationBar.appearance().tintColor = .black
        //        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 20))
        //        statusBarView.backgroundColor = .black
        //        self.window?.rootViewController?.view.insertSubview(statusBarView, at: 0)
        if let barFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 24) {// создаем по условию константу, которой присваиваем шрифт и размер
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: barFont] // настраиваем наш навбар, деламем заголовок белым, и присваиваем наш шрифт к этой настройке
        }
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    
    // MARK: - Table view data source
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        
    }
    
    
    // MARK: - Table view data source
    func applicationWillTerminate(_ application: UIApplication) {
        self.coreDataStack.saveContext()
    }
    
}

