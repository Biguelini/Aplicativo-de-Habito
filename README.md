# Agenda Flutter Mobile

Projeto desenvolvido para a disciplina de **Programação de Dispositivos Móveis** do curso de **Análise e Desenvolvimento de Sistemas** na **UTFPR**.

---

## Sobre o Projeto

Este aplicativo mobile, criado em **Flutter**, tem como objetivo o **gerenciamento de hábitos**.  
A plataforma permite **cadastrar, acompanhar, editar, excluir e visualizar hábitos** de forma prática e intuitiva.  
A interface foi projetada priorizando a **simplicidade** e a **experiência do usuário**.

---

## Responsabilidades da Equipe

- **Felipe Thomazini**: Fez a modificação do aplicativo para ele se tornar multi usuários (cada usuário ter seus próprios hábitos).
- **João Pedro Biguelini**: Implementação do cloud firestore.
- **Luiz Gustavo Rodrigues Cardoso**: Implementação da autenticação com o firebase authentication.

---

## Como Instalar

Siga os passos abaixo para rodar o projeto localmente:

1. Clone este repositório:

   ```bash
   git clone https://github.com/Biguelini/Aplicativo-de-Habito.git
   ```

2. Navegue até a pasta do projeto:

   ```bash
   cd caminho/Aplicativo-de-Habito
   ```

3. Instale as dependências necessárias:

   ```bash
   flutter pub get
   ```

4. Instale o Firebase CLI (se ainda não tiver)
   Instale o Node.js (se não tiver): https://nodejs.org/

   ```bash
   npm install -g firebase-tools
   ```

   Faça login no Firebase:

   ```bash
   npm install -g firebase-tools
   ```

5. Configure seu projeto Flutter com Firebase usando flutterfire
   Instale o CLI do FlutterFire:

   ```bash
   dart pub global activate flutterfire_cli
   ```

   Configure o FlutterFire no seu projeto

   ```bash
   flutterfire configure
   ```

6. Execute o projeto em um emulador ou dispositivo real:

   ```bash
   flutter run
   ```

---

## Funcionalidades

- Cadastro, leitura, atualização e remoção (CRUD) de hábitos
- Controle diário de hábitos realizados
- Interface moderna, leve e acessível

---

## Tecnologias

- **Flutter** — Framework para desenvolvimento mobile
- **Dart** — Linguagem de programação utilizada
- **Provider** — Biblioteca para gerenciamento de estado

---
