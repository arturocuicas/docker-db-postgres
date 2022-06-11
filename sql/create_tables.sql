CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE "user" (
  "uuid" uuid PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4 (),
  "full_name" varchar NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "budget" (
  "uuid" uuid PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4 (),
  "user_uuid" uuid NOT NULL,
  "name" varchar,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "category" (
  "uuid" uuid PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4 (),
  "budget_uuid" uuid NOT NULL,
  "name" varchar NOT NULL,
  "created_at" timestamp DEFAULT (now())
);

CREATE TABLE "entry" (
  "uuid" uuid PRIMARY KEY NOT NULL DEFAULT uuid_generate_v4 (),
  "user_uuid" uuid NOT NULL,
  "category_uuid" uuid NOT NULL,
  "description" text,
  "amount" numeric(15, 3) DEFAULT (0.000),
  "created_at" timestamp DEFAULT (now())
);

ALTER TABLE "budget" ADD FOREIGN KEY ("user_uuid") REFERENCES "user" ("uuid");

ALTER TABLE "category" ADD FOREIGN KEY ("budget_uuid") REFERENCES "budget" ("uuid");

ALTER TABLE "entry" ADD FOREIGN KEY ("user_uuid") REFERENCES "user" ("uuid");

ALTER TABLE "entry" ADD FOREIGN KEY ("category_uuid") REFERENCES "category" ("uuid");
