//
//  NewsTableViewController.swift
//  The Dartmouth
//
//  Created by Henry Wilson on 10/4/16.
//  Copyright © 2016 The Dartmouth. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController, XMLParserDelegate {

    var parser: XMLParser = XMLParser()
    var posts: [Post] = []
    var postTitle: String = String()
    var postLink: String = String()
    var eName: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Loading news")
        let url:NSURL = NSURL(string: "http://www.thedartmouth.com/servlet/feed/the-dartmouth-articles-feed")!
        parser = XMLParser(contentsOf: url as URL)!
        parser.delegate = self
        parser.parse()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        if elementName == "item" {
            postTitle = String()
            postLink = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if eName == "title" {
                postTitle += data
            } else if eName == "link" {
                postLink += data
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let post: Post = Post()
            post.postTitle = postTitle
            post.postLink = postLink
            posts.append(post)
        }
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewarticle" {
            let post: Post = posts[tableView.indexPathForSelectedRow!.row]
            let viewController = segue.destination as! ArticleViewController
            viewController.articleLink = post.postLink
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let post: Post = posts[indexPath.row]
        cell.textLabel?.text = post.postTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
