//
//  GameViewController.swift
//  GameCollector
//
//  Created by Ken Krippeler on 31.08.16.
//  Copyright © 2016 Lichtverbunden. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        imagePicker.delegate = self
    }

    @IBAction func photosTapped(_ sender: AnyObject)
    {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        gameImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: AnyObject)
    {
    
    }

    @IBAction func addTapped(_ sender: AnyObject)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let game = Game(context: context)
        game.title = titleTextField.text
        game.image =  NSData(data: UIImagePNGRepresentation(gameImageView.image!)!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
}
