//
//  TableViewController.swift
//  SearchBar
//
//  Created by Hiếu Nguyễn on 7/31/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var heroArray = [Hero]()
    var filteredHeros = [Hero]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Hero"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        setUpHeros()
        filteredHeros = heroArray
    }
    
    private func setUpHeros() {
        
        let hero1 = Hero(name: "DrowRanger", category: "agility", image: #imageLiteral(resourceName: "DrowRanger"))
        
        let hero2 = Hero(name: "Mirana", category: "agility", image: #imageLiteral(resourceName: "Mirana"))
        
        let hero3 = Hero(name: "PhantomAssassin", category: "agility", image: #imageLiteral(resourceName: "PhantomAssassin"))
        
        let hero4 = Hero(name: "TemplarAssassin", category: "agility", image: #imageLiteral(resourceName: "TemplarAssassin"))
        
        let hero5 = Hero(name: "VengefulSpirit", category: "agility", image: #imageLiteral(resourceName: "VengefulSpirit"))
        
        let hero6 = Hero(name: "Abaddon", category: "strength", image: #imageLiteral(resourceName: "Abaddon"))
        
        let hero7 = Hero(name: "EarthShaker", category: "strength", image: #imageLiteral(resourceName: "EarthShaker"))
        
        let hero8 = Hero(name: "Huskar", category: "strength", image: #imageLiteral(resourceName: "Huskar"))
        
        let hero9 = Hero(name: "Phoenix", category: "strength", image: #imageLiteral(resourceName: "Phoenix"))
        
        let hero10 = Hero(name: "Tusk", category: "strength", image: #imageLiteral(resourceName: "Tusk"))
        
        heroArray += [hero1, hero2, hero3, hero4, hero5, hero6, hero7, hero8, hero9, hero10]
        
        
        
        //        // HERO AGILITY
        //        heroArray.append(Hero(name: "DrowRanger", category: .agility, image: "1"))
        //        heroArray.append(Hero(name: "Mirana", category: .agility, image: "2"))
        //        heroArray.append(Hero(name: "PhantomAssassin", category: .agility, image: "3"))
        //        heroArray.append(Hero(name: "TemplarAssassin", category: .agility, image: "4"))
        //        heroArray.append(Hero(name: "VengefulSpirit", category: .agility, image: "5"))
        //
        //        // HERO STRENGTH
        //        heroArray.append(Hero(name: "Abaddon", category: .strength, image: "6"))
        //        heroArray.append(Hero(name: "EarthShaker", category: .strength, image: "7"))
        //        heroArray.append(Hero(name: "Huskar", category: .strength, image: "8"))
        //        heroArray.append(Hero(name: "Phoenix", category: .strength, image: "9"))
        //        heroArray.append(Hero(name: "Tusk", category: .strength, image: "10"))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredHeros.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = filteredHeros[indexPath.row].name
        cell.categoryLabel.text = filteredHeros[indexPath.row].category
        cell.imgView.image = filteredHeros[indexPath.row].image
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as? DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            if let index = heroArray.index(of: filteredHeros[indexPath.row]) {
                detailViewController?.dataObject = heroArray[index]
            }
        }
    }
    
    
    @IBAction func unwindToHeroList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DetailViewController, let hero = sourceViewController.dataObject {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                if let index = heroArray.index(of: filteredHeros[selectedIndexPath.row]) {
                    heroArray[index] = hero
                }
            } else {
                // Add a new hero
                heroArray.append(hero)
                filteredHeros = heroArray
            }
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if let index = heroArray.index(of: filteredHeros[indexPath.row]) {
                heroArray.remove(at: index)
            }
            filteredHeros.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            print("Something")
        }
    }
}


extension TableViewController: UISearchResultsUpdating {
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filteredHeros = searchText.isEmpty ? (heroArray) : (heroArray.filter({ (hero) -> Bool in
            return hero.name.lowercased().contains(searchText.lowercased())
        }))
        tableView.reloadData()
    }
}

