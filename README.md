# Gallery Core

Gallery application for showcasing artwork with bilingual support (Bulgarian/English). Built with Rails, containerized with Docker, and automated with CI workflows.

## Architecture

**Application Stack:**
- Rails 7.1.3 app with PostgreSQL
- Active Storage with database-backed storage (no S3 dependency)
- Multi-stage Docker build for optimized production images
- Docker Compose for local development with health checks

**CI/CD:**
- Smoke tests: validates Rails boot on every push/PR
- Docker CI: builds and tests container image with caching
- No CD pipeline (intentional - manual deployment)

**Development:**
- Docker Compose orchestrates web + PostgreSQL with volume persistence
- Health checks ensure database readiness before app starts
- Bundle and node_modules cached in volumes

## Setup

**Local (without Docker):**

```bash
bundle install
rails db:create db:migrate db:seed
./bin/rails tailwindcss:install
rails server
```

**Docker:**

```bash
docker-compose up
```

## Testing

```bash
rails test
```

Model tests cover Contact validations and Category associations/scopes.

## Tech Stack

- Rails 7.1.3
- PostgreSQL
- Tailwind CSS
- ActiveAdmin
- Active Storage (database-backed)
- Hotwire

## Decisions

**Database-backed Active Storage:** Chosen to avoid S3 complexity for this project size. Images stored in PostgreSQL via `active_storage_db`.

**Minimal CI:** Smoke tests verify boot, Docker CI validates builds. Full test suite runs locally. No CD - deployment is manual.

**Docker Compose for dev:** Simplifies local setup with one command. Production uses multi-stage Dockerfile for smaller images.
