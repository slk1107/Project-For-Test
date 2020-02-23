//
//  MainTableViewController.swift
//  Project for Test
//
//  Created by Kris on 2020/2/20.
//  Copyright © 2020 Kris. All rights reserved.
//

import UIKit

protocol MainTableViewUseCase: class {
    var presenter: MainTablePresenterProtocol! {get set}
    func reloadTableView()
}

class MainTableViewController: UITableViewController {
    var presenter: MainTablePresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension MainTableViewController: MainTableViewUseCase {
   func reloadTableView() {
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension MainTableViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter.numberOfRowsInSection(section: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Description", for: indexPath)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageBackground", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.willDisplay(index: indexPath.row)
    }
}