//
//  CountryDetailViewController.swift
//  TableViews
//
//  Created by Eric Davenport on 11/12/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {

    // expected data is a Country object
    // thsi property gets set in the prepareForSegue method from ContinentsViewController
    var country: Country!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "\(country.fullImageName)")
        
        
        // set title of navigation bar
        title = country.name
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
