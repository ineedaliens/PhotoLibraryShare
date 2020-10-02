//
//  FourthViewController.swift
//  PhotoLibraryShare
//
//  Created by Евгений on 01.10.2020.
//

import UIKit
import WebKit

class FourthViewController: UIViewController, WKNavigationDelegate {
    
    
    // MARK: - VAR, LET, ARRAY CONSTANT
    var url: URL!
    var progressView: UIProgressView!
    var webView: WKWebView!
    
    
    // MARK: - DEINITIALIZATION FOR WEB VIEW OBSERVER
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress)) // Деинициализируем нашего наблюдателя за свойством
    }
    
    
    // MARK: - METHOD VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView() // присваиваем нашу переменную к классу
        webView.navigationDelegate = self // подписываемся под делегата
        view = webView // говорим, что наш вью (полностью) будет заменен на webView
        
        
        // MARK: - CREATE REAUEST AND LOAD REQUEST TO WEB VIEW AND CUSTON SETTINGS
        let request = URLRequest(url: url) // создаем константу запроса и в методе передаем наш URL
        webView.load(request) // вызываем метод загрузку и передаем туда наш запрос
        
        webView.allowsLinkPreview = true // свойство которое позволяет просматривать быстрый просмотр
        webView.allowsBackForwardNavigationGestures = true // свойство, которое позволяет свайпами переходить назад или вперед
        
        
        // MARK: - CREATE PROGRESS VIEW AND BUTTON TO WEB VIEW
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView) // размещаем нащ прогрессвью в наш прогресс баттон
        let flexibleSpacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // создаем спейсер в наш бар
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload)) // создаем кнопку рефреш в наш бар
        
        toolbarItems = [progressButton, flexibleSpacer, refreshButton] // вызываем стандартный массив и складываем в него наши созданые элементы
        navigationController?.isToolbarHidden = false // вызываем свойство, которое не позволяет бару скрываться
        
        
        // MARK: - CREATE OBSERVE TO PROGRESS VIEW AND PROGRESS BUTTON
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) // создаем наблюдателя для нашего вебвью для того чтобы прогресс баттон корректно работал
    }
    
    
    // MARK: METHOD OBSERVE VALUE WHEN OUR PROGRESS VIEW = WEB VIEW ESTIMATED PROGRESS
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" { // если наш кей паф (путь) равен "",
            progressView.progress = Float(webView.estimatedProgress) //то мы говорим что, свойство прогресс нашего прогрессВью присваивается из вебВьююестимайтеПрогресс - то есть то что фактически происходит при загрузке страницы
        }
    }
    
    // MARK: - METHOD DID FINISH
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
