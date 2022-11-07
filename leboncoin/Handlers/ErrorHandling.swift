//
//  ErrorHandling.swift
//  leboncoin
//
//  Created by Kandara Marouene on 05/11/2022.
//

import Foundation
import UIKit

class ErrorHandling {
    static func handleFail(_ vc : UIViewController, title: String, body: String) {
        let controller = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let ok = UIAlertAction(title: ErrorMessage.OK_BUTTON , style: .default, handler: nil)
        controller.addAction(ok)
        vc.present(controller, animated: true, completion: nil)
    }
}

struct ErrorMessage {
    static let TITLE = "Erreur"
    static let BODY_ITEMS = "Erreur lors de la récupération des éléments"
    static let BODY_CATEGORY = "Erreur lors de la récupération de la catégorie"
    static let BODY_GENERIC = "Erreur générique"
    static let OK_BUTTON = "Ok"
}
