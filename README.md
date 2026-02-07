# Project Scaffolder

A template-based project generator that creates downloadable ZIP archives with variable substitution. Built with Rails 8 API + React 19 frontend.

## Features

- **Template Library** - Browse and create project templates with file structures defined as JSON
- **Variable Substitution** - `{{project_name}}` and other placeholders replaced at generation time
- **ZIP Downloads** - Generated projects packaged as downloadable ZIP archives
- **Custom Templates** - Create and share your own project templates
- **Download Tracking** - Track generation history and download counts

## Included Templates

| Template | Description |
|----------|-------------|
| React + Vite | Modern React with Vite, Tailwind CSS, and routing |
| Express API | Node.js Express REST API scaffold |
| Rails API | Rails 8 API-only application |

## Tech Stack

**Backend:** Ruby on Rails 8.1, SQLite, Puma, JWT Auth, RubyZip

**Frontend:** React 19, Vite 7, Tailwind CSS 4, React Router 6, Axios

**Testing:** RSpec, FactoryBot

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/auth/register` | Create account |
| POST | `/auth/login` | Get JWT token |
| GET | `/templates` | List public + user templates |
| POST | `/templates` | Create custom template |
| POST | `/projects/generate` | Generate ZIP from template |
| GET | `/projects` | List generated projects |

## Setup

```bash
# Backend
cd /path/to/project-scaffolder
bundle install
rails db:create db:migrate db:seed
rails server -p 3001

# Frontend
cd frontend
npm install
npm run dev
```

## Deploy

Backend deploys to Render (free tier), frontend to Vercel. Seeds default templates on first deploy. See `render.yaml` for configuration.

## License

MIT
