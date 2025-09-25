# Tasks Organizer - PostgreSQL (docker-compose)

Database configuration and setup for the [Tasks Organizer application. ](https://github.com/UmbrellaLeaf5/tasks_organizer)

## Database Schema

### Tables Structure

#### Users Table

- `id` (BIGINT) - Primary key, auto-incrementing sequence
- `short_name` (TEXT) - Unique user identifier
- `name` (TEXT) - Full user name

#### Notes Table

- `id` (BIGINT) - Primary key, auto-incrementing sequence
- `author_id` (BIGINT) - Foreign key referencing users(id) with CASCADE delete
- `title` (TEXT) - Unique note title
- `text` (TEXT) - Note content (default: empty string)
- `created_at` (TIMESTAMP) - Creation timestamp (default: current timestamp)

### Sequences

- `users_id_seq` - Starts at 1, increments by 50
- `notes_id_seq` - Starts at 1, increments by 50

## Quick Start

### 1. Environment Setup

Copy the example environment file:

```bash
cp .env.example .env
```

Edit `.env` with your database credentials:

```env
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_DB=tasks_organizer
POSTGRES_USER=admin
POSTGRES_PASSWORD=password
```

### 2. Start Database

Run the setup script:

```bash
chmod +x restart.sh
./restart.sh
```

This will:

- Start PostgreSQL container
- Initialize database schema
- Load sample data

### 3. Verify Connection

The database will be available at:

- Host: `localhost`
- Port: `5432`
- Database: `tasks_organizer`

## Sample Data

The database comes pre-loaded with sample data:

### Users

- 5 test users with Russian names and short identifiers

### Notes

- 10 sample notes covering various topics:
  - Shopping lists
  - Project ideas
  - Recipes
  - Meeting schedules
  - Book recommendations
  - Financial reports
  - Weekend plans
  - Annual goals
  - Contact lists

## Docker Configuration

### Services

- **postgres**: Latest PostgreSQL image
- **Healthcheck**: Automatically verifies database readiness
- **Volume**: Persistent data storage (`db-data`)

### Port Mapping

- Host: `${POSTGRES_PORT}` (default: 5432)
- Container: 5432

## Manual Database Operations

### Connect to Database

```bash
docker-compose exec postgres psql -U $POSTGRES_USER -d $POSTGRES_DB
```

### View Tables

```sql
\dt
```

### Query Users

```sql
SELECT * FROM users;
```

### Query Notes

```sql
SELECT * FROM notes;
```

## Database Initialization Files

### init.sql

- Drops existing sequences and tables
- Creates new sequences with optimized allocation
- Defines table schema with proper constraints
- Sets up foreign key relationships

### primary_data.sql

- Inserts sample users and notes
- Provides realistic test data for development
- Includes varied content types and formats

## Security Notes

- `.env` is included in `.gitignore` for security
- Use strong passwords in production
- Consider network security for database exposure
- Regular backups recommended for production data

## Schema Diagram

```
users (1) ←→ (∞) notes
```

- One-to-many relationship
- CASCADE delete: deleting a user removes their notes
- Unique constraints on user.short_name and note.title
