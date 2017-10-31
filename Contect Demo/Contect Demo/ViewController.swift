//
//  ViewController.swift
//  Contect Demo
//
//  Created by MacStudent on 2017-10-30.
//  Copyright © 2017 Dhruvi Patel. All rights reserved.
//https://code.tutsplus.com/tutorials/ios-9-an-introduction-to-the-contacts-framework--cms-25599

//https://code.tutsplus.com/tutorials/ios-9-an-introduction-to-the-contacts-framework--cms-25599 to solve problems


import UIKit
import Contacts
import ContactsUI


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , CNContactPickerDelegate
{

    @IBOutlet weak var tbl_display_contacts: UITableView!
    
    var contacts = [CNContact]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getContacts()
      
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        //self.present(cnPicker, animated: true, completion: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }

    func click_Contact(_ sender: Any) // call on any click event
    {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact])
    {
        contacts.forEach { contact in
            for number in contact.phoneNumbers
            {
                let phoneNumber = number.value
                print("number is = \(phoneNumber)")
            }
        }
    }
    
    
    //-------------------------   Table methods
    func contactPickerDidCancel(_ picker: CNContactPickerViewController)
    {
        print("Cancel Contact Picker")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].givenName
        cell.detailTextLabel?.text = contacts[indexPath.row].familyName //.emailAddresses[0].value as String
        return cell
    }
    //-------------------------   Table methods

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getContacts()
    {
        let store = CNContactStore()
        // create object
        
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined // ask permission
        {
            store.requestAccess(for: .contacts, completionHandler: { (authorized, error)  in
                if authorized
                {
                    self.retrieveContactsWithStore(store: store) // allow then read contect
                    self.getAllContacts(store: store)
                }
            })
        }
        else if CNContactStore.authorizationStatus(for: .contacts) == .authorized // already set
        {
            // allow n read contect
            self.retrieveContactsWithStore(store: store)
        }
    }

    func displayContacts()
    {
        for contact in contacts
        {
            print("\n GivenName : ", contact.givenName)
            print("Name : \(contact.familyName)")
            if contact.emailAddresses.count != 0
            {
                print("Email: \(String(describing: contact.emailAddresses[0].value))")
            }
           // print("Email: \(String(describing: contact.emailAddresses[0].value(forKey: "value") as! String!))")
        }
    }
    
    

    // Create New Contact
    func createCNContactWithFirstName(_ firstName: String, lastName: String, email: String?, phone: String?, image: UIImage?)
    {
        // create contact with mandatory values: first and last name
        let newContact = CNMutableContact()
        newContact.givenName = firstName
        newContact.familyName = lastName
        
        // email
        if email != nil
        {
            let contactEmail = CNLabeledValue(label: CNLabelHome, value: email! as NSString)
            newContact.emailAddresses = [contactEmail]
        }
        // phone
        if phone != nil
        {
            let contactPhone = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: phone!))
            newContact.phoneNumbers = [contactPhone]
        }
        
        // image
        if image != nil
        {
            newContact.imageData = UIImageJPEGRepresentation(image!, 0.9)
        }
        
        do
        {
            let newContactRequest = CNSaveRequest()
            newContactRequest.add(newContact, toContainerWithIdentifier: nil)
            try CNContactStore().execute(newContactRequest)
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        catch
        {
            //self.showAlertMessage("I was unable to create the new contact. An error occurred.")
        }
    }
 
    
    func getAllContacts(store: CNContactStore)
    {
        contacts = [CNContact]()
        do
        {
            let contactsFetchRequest = CNContactFetchRequest(keysToFetch: [
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactImageDataKey as CNKeyDescriptor,
                CNContactImageDataAvailableKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor,
                CNContactEmailAddressesKey as CNKeyDescriptor])
            try store.enumerateContacts(with: contactsFetchRequest, usingBlock: { (cnContact, error) in
                DispatchQueue.main.async
                {
                    self.contacts = [cnContact]
                    self.displayContacts()
                    self.contacts.append(cnContact)
                    self.tbl_display_contacts.reloadData()
                }

            })
        }
        catch
        {
            print("Error fetching contacts...")
        }
     }
    
      func retrieveContactsWithStore(store: CNContactStore)
    {
        do
        {
            let groups = try store.groups(matching: nil	) // no group matching
            let req = CNContactFetchRequest(keysToFetch:
                [ CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactGivenNameKey as CNKeyDescriptor ])
            
            
            
            let predicate = CNContact.predicateForContactsInGroup(withIdentifier: groups[0].identifier)
                //let predicate = CNContact.predicateForContactsMatchingName("John")
            
            // get full nameand return collection of group name
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactEmailAddressesKey] as [Any]
            
           // return collection of group name
            contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
            print("Contect ------------  :  " , contacts.description)
            
            displayContacts()
            
            print("\n GivenName : ", contacts[0].givenName)
            print("FamilyName : ", contacts[0].familyName)
            print("EmailAddresses : ", contacts[0].emailAddresses[0].value(forKey: "value") as! String! )
            //print("PostalAddresses : ", contacts[0].postalAddresses)
            //print("PhoneNumbers : ", contacts[0].phoneNumbers)
            
            var mycontect = CNContact()
            try! CNContactStore().enumerateContacts(with: req)
            {
                mycontect , stop in
                //print(mycontect.description) // in real life, probably populate an array
                self.contacts.append(mycontect)
            }
            
            
            DispatchQueue.main.async
            {
                //print("----- DispatchQueue.main" )
               // self.contacts.append()
                self.tbl_display_contacts.reloadData()
            }
        }
        catch
        {
            print(error)
        }
    }//retrieveContactsWithStore
} // viewcolntroller







//func configureView()
//{
    // Update the user interface for the detail item.
    //        if let oldContact = self.contactItem
    //        {
    //            let store = CNContactStore()
    //
    //            do {
    //                let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactEmailAddressesKey, CNContactPostalAddressesKey, CNContactImageDataKey, CNContactImageDataAvailableKey] as [Any]
    //                let contact = try store.unifiedContactWithIdentifier(oldContact.identifier, keysToFetch: keysToFetch)
    //
    //
    //                DispatchQueue.main.async
    //                {
    //                    if contact.imageDataAvailable
    //                    {
    //                        if let data = contact.imageData
    //                        {
    //                            //self.contactImage.image = UIImage(data: data)
    //                        }
    //                }
    //                    self.fullName.text = CNContactFormatter().stringFromContact(contact)
    //                    self.email.text = contact.emailAddresses.first?.value as? String
    //                    if contact.isKeyAvailable(CNContactPostalAddressesKey)
    //                    {
    //                        if let postalAddress = contact.postalAddresses.first?.value as? CNPostalAddress
    //                        {
    //                            //self.address.text = CNPostalAddressFormatter().stringFromPostalAddress(postalAddress)
    //                        }
    //                        else
    //                        {
    //                            //self.address.text = "No Address"
    //                        }
    //                    }
    //                })
    //            }
    //            catch
    //            {
    //                print(error)
    //            }
    //        }
//} //configureView



//    var contact: CNContact
//    {
//        get
//        {
//            let store = CNContactStore()

//            let contactToAdd = CNMutableContact()
//            contactToAdd.givenName = self.firstName.text ?? ""
//            contactToAdd.familyName = self.lastName.text ?? ""
//
//            let mobileNumber = CNPhoneNumber(stringValue: (self.mobileNumber.text ?? ""))
//            let mobileValue = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: mobileNumber)
//            contactToAdd.phoneNumbers = [mobileValue]
//
//            let email = CNLabeledValue(label: CNLabelHome, value: (self.homeEmail.text ?? ""))
//            contactToAdd.emailAddresses = [email]
//
//            if let image = self.contactImage.image
//            {
//                contactToAdd.imageData = UIImagePNGRepresentation(image)
//            }
//
//            let saveRequest = CNSaveRequest()
//            saveRequest.addContact(contactToAdd, toContainerWithIdentifier: nil)
//
//            do
//            {
//                try store.executeSaveRequest(saveRequest)
//            }
//            catch
//            {
//                print(error)
//            }
//
//            return contactToAdd
//        }
//    }

