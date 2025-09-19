CREATE TABLE
  "notes" (
    "id" BIGINT NOT NULL,
    "author_id" BIGINT NOT NULL,
    "title" TEXT NOT NULL,
    "text" TEXT NOT NULL DEFAULT '""',
    "created_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL
  );

CREATE TABLE
  "users" (
    "id" BIGINT NOT NULL,
    "short_name" TEXT NOT NULL,
    "name" TEXT NOT NULL
  );

-- MARK: primary key
ALTER TABLE "users" ADD PRIMARY KEY ("id");

ALTER TABLE "notes" ADD PRIMARY KEY ("id");

-- MARK: foreign key
ALTER TABLE "notes" ADD CONSTRAINT "notes_author_id_foreign" FOREIGN KEY ("author_id") REFERENCES "users" ("id") ON DELETE CASCADE;

-- MARK: unique
ALTER TABLE "notes" ADD CONSTRAINT "notes_title_unique" UNIQUE ("title");

ALTER TABLE "users" ADD CONSTRAINT "users_short_name_unique" UNIQUE ("short_name");
