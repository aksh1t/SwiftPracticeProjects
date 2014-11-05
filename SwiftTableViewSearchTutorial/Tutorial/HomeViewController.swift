//
//  HomeViewController.swift
//  Tutorial
//
//  Created by Akshat on 05/11/14.
//  Copyright (c) 2014 aksh1t. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate{
    
    @IBOutlet var tableView: UITableView?
    
    var candies = [Candy]()
    var filteredCandies = [Candy]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Candy List"
        
        self.tableView!.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        self.searchDisplayController!.searchResultsTableView!.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        
        self.candies = [Candy(category:"Chocolate", name:"Chocolate Bar"),
            Candy(category:"Chocolate", name:"Chocolate Chip"),
            Candy(category:"Chocolate", name:"Dark chocolate"),
            Candy(category:"Hard", name:"Lollipop"),
            Candy(category:"Hard", name:"Candy cane"),
            Candy(category:"Hard", name:"Jaw breaker"),
            Candy(category:"Other", name:"Caramel"),
            Candy(category:"Other", name:"Sour chew"),
            Candy(category:"Other", name:"Gummi bear")]
        
        // Reload the table
        self.tableView!.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredCandies.count
        } else {
            return self.candies.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        let cell = self.tableView!.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        var candy : Candy
        // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
        if tableView == self.searchDisplayController!.searchResultsTableView {
            candy = filteredCandies[indexPath.row]
        } else {
            candy = candies[indexPath.row]
        }
        
        // Configure the cell
        cell.textLabel!.text = candy.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        let scopes = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
        let selectedScope = scopes[self.searchDisplayController!.searchBar.selectedScopeButtonIndex] as String
        self.filterContentForSearchText(searchString, scope: selectedScope)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        let scope = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text, scope: scope[searchOption])
        return true
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredCandies = self.candies.filter({( candy : Candy) -> Bool in
            var categoryMatch = (scope == "All") || (candy.category == scope)
            var stringMatch = candy.name.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
        })
    }
}