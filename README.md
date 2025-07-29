# 📦 MiniMeli

**MiniMeli** é um app iOS em Swift que consome a API do Mercado Livre, permitindo buscas de produtos e visualização de detalhes, com autenticação via OAuth2.

## ✨ Funcionalidades

- Busca de produtos
- Lista com layout dinâmico
- Detalhes do produto (preço, imagens, descrição)
- Suporte a loading, erro e vazio
- OAuth2 com token persistente

## 🧱 Tecnologias

- Swift 5.9, UIKit
- MVVM + Coordinator
- Swift Concurrency (`async/await`)
- ViewCode (sem Storyboard)
- SnapshotTesting

## 🧪 Testes

- Testes de snapshot com `SnapshotTesting`
- Spies e Mocks para ViewModels e Services
- XCTest + cobertura de UI

## 🚀 Execução

1. Clone o projeto
2. Configure o token OAuth manualmente
2.a Usando o fluxo com mock, utilize as seguintes palavras na busca: Arroz ou Cafe
3. Rode com `⌘ + R`
4. Testes com `⌘ + U`
