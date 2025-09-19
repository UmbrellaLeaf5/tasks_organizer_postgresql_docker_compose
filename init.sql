CREATE TABLE
  "questions" (
    "id" UUID NOT NULL,
    "title" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "user_id" UUID NOT NULL,
    "created_at" DATE NOT NULL,
    "is_moderated" BOOLEAN NOT NULL DEFAULT FALSE,
    "is_hidden" BOOLEAN NOT NULL DEFAULT FALSE
  );

CREATE TABLE
  "users" (
    "id" UUID NOT NULL,
    "short_name" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "surname" VARCHAR(255) NULL,
    "role" VARCHAR(255) CHECK ("role" IN ('USER', 'MODER', 'ADMIN')) NOT NULL DEFAULT 'USER',
    "position" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL
  );

-- MARK: primary key
ALTER TABLE "questions" ADD PRIMARY KEY ("id");

ALTER TABLE "users" ADD PRIMARY KEY ("id");

-- MARK: foreign key
ALTER TABLE "questions" ADD CONSTRAINT "questions_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE;

-- MARK: unique
ALTER TABLE "users" ADD CONSTRAINT "users_short_name_unique" UNIQUE ("short_name");

ALTER TABLE "users" ADD CONSTRAINT "users_email_unique" UNIQUE ("email");
