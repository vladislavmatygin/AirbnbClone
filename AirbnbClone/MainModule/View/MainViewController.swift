//
//  MainViewController.swift
//  AirbnbClone
//
//  Created by Владислав Матыгин on 14.12.2021.
//

import UIKit

class MainViewController: UIViewController {
    var viewModel: MainViewModel?
    @IBOutlet private var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .label
        
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "cell")
    }
    
    private func configureItems() {
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "setting"),
                            style: .done,
                            target: self,
                            action: nil)
        ]
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        cell.config(floor: viewModel.floorsArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }

        let floor = viewModel.floorsArray[indexPath.row]
        let detailedViewModel = DetailedViewModel(floor: floor)
        let viewController = DetailViewController()
        viewController.viewModel = detailedViewModel
        navigationController?.pushViewController(viewController, animated: true)
    }
}
