//
//  SongsVC.swift
//  shuffle-songs
//
//  Created by Humberto Vieira on 22/05/19.
//  Copyright © 2019 Humberto Vieira. All rights reserved.
//

import UIKit

class SongsVC: UIViewController {
    private let mainView: SongsView
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private let viewModel = SongsViewModel()
    
    init() {
        self.mainView = SongsView(frame: .zero)
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Shuffle Songs"
        configNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configIndicator()
        mainView.setupViewConfiguration()
        viewModel.getSongs()
    }
    
    @objc func shuffle() {
        self.activityIndicator.startAnimating()
    }
    
    func addSubviews() {
        self.view.addSubview(mainView)
        self.view.addSubview(activityIndicator)
    }
    
    func configTableView() {
        self.mainView.delegate = viewModel
        self.mainView.dataSource = viewModel
    }
    
    func configNavigationBar() {
        var image = UIImage(named: "button_shuffle")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        UINavigationBar.appearance().barTintColor = UIColor(displayP3Red: 57/255.0, green: 38/255.0, blue: 52/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(shuffle))
    }
    
    func configIndicator() {
        activityIndicator.frame.size = CGSize(width: self.view.frame.width/4, height: self.view.frame.width/4)
        activityIndicator.center = self.view.center
    }
}
