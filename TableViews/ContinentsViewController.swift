//
//  ContinentsViewController.swift
//  TableViews
//
//  Created by Eric Davenport on 11/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ContinentsViewController: UIViewController {

    // TODO:
    // 1. connect tableView using an IBOutlet
    // 2. set viewController as data source for tableView in viewDidLoaad
    // 3. use extension on the ContinentsViewController and conform to UITableViewDataSource
    // 4. implement required methods
    
    
    // 1. connect tableView using an IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    private var continents = [[Country]]() {
        didSet {  // property observer, gets called when conttinents is changed or set
            tableView.reloadData()    // hen didSet is called - reload data RELOADS ALL CONTENTS of tableview
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 2. set viewController as data source for tableView in viewDidLoaad
        tableView.dataSource = self
        
        // test continent section
        // dump(Country.getSections())
        loadData()
        
    }
    
    // helper method
    func loadData() {
        continents = Country.getSections()
    }
    // called everytime a segue is called
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue")
        
        // here is where we will pass data from the ContinentsViewController to the
        // the CountryDetailViewController
        
        // we will pass the selected country to the CountryDetailViewController
        
        // segue has a .source and a .destination property
        
        guard let countryDVC = segue.destination as? CountryDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
            return  // return with a return value returns nothing - exits the function
        }
        
        // set country on CountryDVC
        countryDVC.country = continents[indexPath.section][indexPath.row]
        
    }

}
// 3. use extension on the ContinentsViewController and conform to UITableViewDataSource

extension ContinentsViewController: UITableViewDataSource {
    
    
    // 4. implement required methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Data for tableView is an array of arrays [[Country]]
        // no longer can we simply return continents.count
        // this should return 5 in our cases, since we have 5 sectio s 9continents0 currently
        // [sections].count on the array of arrays
        return continents[section].count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        // we need to gt the current object at the current indexPath
        let country = continents[indexPath.section][indexPath.row]
        
        // 3. configure cell
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.description
        //cell.detailTextLabel?.numberOfLines = 0
        cell.imageView?.image = UIImage(named: "\(country.thumbnailImageName)")
        
       return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return continents.count // 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return continents[section].first?.continent
    }
}
    
