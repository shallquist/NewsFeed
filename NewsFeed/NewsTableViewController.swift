//
//  NewsTableViewController.swift
//  NewsFeed
//
//  Created by steig hallquist on 6/8/18.
//  Copyright © 2018 steig hallquist. All rights reserved.
//

import UIKit

private let Segue = "ShowDetail"

class NewsTableViewController: UITableViewController {
    var newsItems:[DataFeed.Result]?
    var selectedIndexPath:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItems?.count ?? 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NewsFeed.getData { (dataFeed, error) in
            if let data = dataFeed, error == nil {
                self.newsItems = data.items.result
                self.tableView.reloadData()
            }
            else {
                let alertVC = UIAlertController(title: nil, message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alertVC.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
                
                self.present(alertVC, animated: true, completion: nil)

                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let news = newsItems?[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else
        {
            return UITableViewCell()
        }

        // Configure the cell...
        cell.newsContent = news.content

        return cell
    }



    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ip = self.tableView.indexPathForSelectedRow, let destVC = segue.destination as? ViewController {
            destVC.url = newsItems?[ip.row].content.url
        }
    }


}
