//
//  MiniMeliAlertView.swift
//  MiniMeli
//
//  Created by Tiago P. Coelho on 28/07/25.
//

import UIKit

final class MiniMeliAlertView: UIAlertController {

    private var onSubmit: ((String) -> Void)?

    static func create(onSubmit: @escaping (String) -> Void) -> MiniMeliAlertView {
        let alert = MiniMeliAlertView(
            title: "Autenticação",
            message: "Cole seu código: TG-1234...",
            preferredStyle: .alert
        )
        alert.onSubmit = onSubmit

        alert.addTextField { textField in
            textField.placeholder = "TG-XXXXXX..."
            textField.autocapitalizationType = .none
            textField.keyboardType = .default
        }

        let enviar = UIAlertAction(title: "Enviar", style: .default) { _ in
            guard let code = alert.textFields?.first?.text, !code.isEmpty else {
                print("Código vazio")
                return
            }
            onSubmit(code)
        }

        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)

        alert.addAction(cancelar)
        alert.addAction(enviar)

        return alert
    }
}
