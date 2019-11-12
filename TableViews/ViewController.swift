//
//  ViewController.swift
//  TableViews
//
//  Created by Alex Paul on 11/11/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  /*
   ## Topics Covered
   
   * UITableView
   * cells can be static or dynamic
   * prototype cell
   * reuse identifier e.g "countryCell"
   * dataSource object (WE NEED TO SET THE DATASOURCE OBJECT e.g tableView.dataSource = self), configured in viewDidLoad()
   * UITableViewDataSource - 2 required methods
   * first required method is numberOfRows()
   * second required methods is cellForRow()
   * dequeueCell - recycles a cell if in memory, if not it creates a new cell
  */
  
  // MARK:- outlets and properties
  
  @IBOutlet weak var tableView: UITableView!
  
  // data for the table view // [Country]
  private var countries = [Country]() { // empty array
    // property observer
    // e.g countries = Country.countries
    didSet {
      // reload the table view
      // reloads all the rows of the table view
      tableView.reloadData()
    }
  }
  
  private var sortAscending = true
  
  // MARK:- viewcontroller life cycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // configuring a table view
    // Step 1: set the data source object
    // meaning the object that will provie the table view its data (cell data)
    tableView.dataSource = self // is the ViewController instance, e.g self
    
    // testing data
    print("There are \(Country.countries.count) countries in our struct")
    
    sortData(true)
  }
  
  @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
    sortAscending.toggle()
    sortData(sortAscending)
  }
  
  func sortData(_ sortAscending: Bool) {
    if sortAscending {
      countries = Country.countries.sorted { $0.name < $1.name } // < ascending
      // our table view reloads because we are using a property observer didSet {...}
      // willSet{....}
      // update the UIBarButtonItem's title that we dragged into interface builder
      navigationItem.rightBarButtonItem?.title = "Sort Descending"
    } else {
      countries = Country.countries.sorted { $0.name > $1.name }
      navigationItem.rightBarButtonItem?.title = "Sort Ascending"
    }
  }
}

// Step 2: conform to UITableViewDataSource
extension ViewController: UITableViewDataSource {
  // 2 REQUIRED METHODS
  
  // method 1: numberOfRows
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countries.count
  }
  
  // method 2:
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // dequeueReusableCell:
    // recycles a cell if it exist
    // if the cell does not exist a new cell is created
    // get a cell using currentIndex
    let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
    
    // get the object (country) at the current indexPath
    let country = countries[indexPath.row]
    
    // configure the cell
    cell.textLabel?.text = country.name
    cell.detailTextLabel?.text = country.description
    
//    let arrOfArrays = [[1,2,3],
//                       [4,5,6],
//                       [7,8,9]]
    // arrOfArrays[indexPath.section][indexPath.row]
    // arrOfArrays[0][0] // prints out 1
    
    //let flatArr = [1, 2, 3]
    //flatArr[indexPath.row]
    return cell
  }
}
