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
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var game : Game? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if game != nil
        {
            gameImageView.image = UIImage(data: game!.image as! Data)
            titleTextField.text = game!.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        }
        else
        {
            deleteButton.isHidden = true
        }
        
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
        if game != nil
        {
            game!.title = titleTextField.text
            game!.image =  NSData(data: UIImagePNGRepresentation(gameImageView.image!)!)
        }
        else
        {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let game = Game(context: context)
            game.title = titleTextField.text
            game.image =  NSData(data: UIImagePNGRepresentation(gameImageView.image!)!)
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: AnyObject)
    {
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(game!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
}
