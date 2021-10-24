//
//  ListViewController.swift
//  RickAndMorty
//
//  Created by Александр Жуков on 24.10.2021.
//

import UIKit
import AlamofireImage

class ListViewController: UIViewController {
    
    let parser = Parser()
    let network = Network()
    var characters: Characters?
    var results: Results?
    var lastResponse: Characters?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        if characters == nil {
            loadCharacters(searchUrl: url)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            let DetailVC = segue.destination as! DetailViewController
            
            DetailVC.detailResults = results
            DetailVC.detailCharacters = characters
        }
    }
    
    func loadCharacters(searchUrl: String){
        self.parser.parseCharacters(urlString: searchUrl) { characters in
        guard let characters = characters else { return }
        self.characters = characters
        self.lastResponse = characters
        self.tableView.reloadData()
        }
    }
    
    func loadMore(searchUrl: String){
        self.parser.parseCharacters(urlString: searchUrl) { newCharacters in
        guard let characters = newCharacters else { return }
        self.characters?.results += characters.results
        self.lastResponse? = characters
        self.tableView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersCell") as! CharactersCell
        let character = characters?.results[indexPath.row]
        
        cell.nameLabel.text = character?.name
        cell.speciesLabel.text = character?.species
        cell.characterImage.af.setImage(withURL: URL(string: character!.image)!, placeholderImage: UIImage(named: "placeholder")!)
        
        if indexPath.row == (characters?.results.count)! - 2 && lastResponse?.info.next != nil {
            loadMore(searchUrl: (lastResponse?.info.next)!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentCharacter = characters?.results[indexPath.row]
        results = currentCharacter
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
    }

}

extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.components(separatedBy: " ").filter { !$0.isEmpty }.joined(separator: "+")
        loadCharacters(searchUrl: "https://rickandmortyapi.com/api/character/?name=\(text)")
    }
}
