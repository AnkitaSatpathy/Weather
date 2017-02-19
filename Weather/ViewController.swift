//
//  ViewController.swift
//  Weather
//
//  Created by Ankita Satpathy on 26/12/16.
//  Copyright © 2016 Ankita Satpathy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func seeWeather(_ sender: Any) {
        
        var wasSuccessful = false
        
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + cityField.text!.replacingOccurrences(of: "", with: "- ") + "/forecasts/latest")
        
        if let url = url {
            
            let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) -> Void in
                
                if data != nil {
                    
                    let webContent = NSString(data :data! , encoding : String.Encoding.utf8.rawValue)
                    let websiteArray = webContent!.components(separatedBy: "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    if websiteArray.count > 1 {
                        let weatherArray = websiteArray[1].components(separatedBy: "</span>")
                        
                        print(weatherArray[0])
                        if weatherArray.count > 1{
                            
                            wasSuccessful = true
                            
                            let weatherSumary = weatherArray[0].replacingOccurrences(of: "&deg;", with: "º")
                            DispatchQueue.main.async(execute: { () -> Void in
                                
                                self.resultLabel.text = weatherSumary
                            })
                            
                        }
                        
                    }
                    
                    if wasSuccessful == false{
                       self.resultLabel.text =  "Couldn't find the weather for that city - please try again."
                    }
                }
                else  {
                    self.resultLabel.text =  "Couldn't find the weather for that city - please try again."
                }
            }
            task.resume()
            
        }
        

    }
    
        override func viewDidLoad() {
            
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            }
    
}



