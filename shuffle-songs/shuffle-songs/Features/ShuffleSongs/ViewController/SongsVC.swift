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
        
        self.activityIndicator.startAnimating()
    }
    
    @objc func shuffle() {
        self.activityIndicator.startAnimating()
        
        viewModel.shuffleSongs { [weak self] in
            self?.mainView.reloadData()
            self?.activityIndicator.stopAnimating()
            
        }
    }
    
    func addSubviews() {
        self.view.addSubview(mainView)
        self.view.addSubview(activityIndicator)
    }
    
    func configTableView() {
        self.mainView.delegate = viewModel
        self.mainView.dataSource = viewModel
        self.viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.mainView.reloadData()
            }
        }
    }
    
    func configNavigationBar() {
        var image = UIImage(named: "button_shuffle")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        UINavigationBar.appearance().barTintColor = Colors.navColor
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : Colors.textColor]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(shuffle))
    }
    
    func configIndicator() {
        activityIndicator.frame.size = CGSize(width: self.view.frame.width/4, height: self.view.frame.width/4)
        activityIndicator.center = self.view.center
    }
}
