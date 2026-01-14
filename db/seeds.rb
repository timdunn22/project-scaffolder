# Seed templates
templates = [
  {
    name: 'React + Vite',
    description: 'Modern React application with Vite build tool and Tailwind CSS',
    is_public: true,
    file_structure: {
      'package.json' => '{"name": "{{project_name}}", "version": "1.0.0", "scripts": {"dev": "vite", "build": "vite build"}}',
      'vite.config.js' => 'import { defineConfig } from "vite"\nimport react from "@vitejs/plugin-react"\nexport default defineConfig({ plugins: [react()] })',
      'index.html' => '<!DOCTYPE html><html><head><title>{{project_name}}</title></head><body><div id="root"></div><script type="module" src="/src/main.jsx"></script></body></html>',
      'src' => {
        'main.jsx' => 'import React from "react"\nimport ReactDOM from "react-dom/client"\nimport App from "./App"\nReactDOM.createRoot(document.getElementById("root")).render(<App />)',
        'App.jsx' => 'export default function App() { return <h1>Hello {{project_name}}!</h1> }'
      }
    }
  },
  {
    name: 'Express API',
    description: 'Node.js Express REST API with basic routing',
    is_public: true,
    file_structure: {
      'package.json' => '{"name": "{{project_name}}", "version": "1.0.0", "main": "index.js", "scripts": {"start": "node index.js", "dev": "nodemon index.js"}}',
      'index.js' => 'const express = require("express")\nconst app = express()\napp.use(express.json())\napp.get("/", (req, res) => res.json({ message: "Welcome to {{project_name}}" }))\napp.listen(3000, () => console.log("Server running on port 3000"))',
      'routes' => { '.gitkeep' => '' },
      'controllers' => { '.gitkeep' => '' }
    }
  },
  {
    name: 'Rails API',
    description: 'Ruby on Rails API-only application',
    is_public: true,
    file_structure: {
      'Gemfile' => 'source "https://rubygems.org"\ngem "rails", "~> 8.0"\ngem "sqlite3"\ngem "puma"',
      'config.ru' => 'require_relative "config/environment"\nrun Rails.application',
      'app' => {
        'controllers' => {
          'application_controller.rb' => 'class ApplicationController < ActionController::API\nend'
        }
      },
      'config' => {
        'application.rb' => 'require_relative "boot"\nrequire "rails/all"\nmodule {{project_name}}\n  class Application < Rails::Application\n    config.api_only = true\n  end\nend'
      }
    }
  }
]

templates.each do |t|
  Template.find_or_create_by!(name: t[:name]) do |template|
    template.description = t[:description]
    template.is_public = t[:is_public]
    template.file_structure = t[:file_structure]
  end
end

puts "Seeded #{Template.count} templates"
