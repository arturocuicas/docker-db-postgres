-- User
WITH c (
    user_uuid
    ) as (
   values (
        uuid_generate_v4 ()
   )
)

insert into "user" (uuid, full_name) values(
    (select user_uuid from c),
    'John Doe'
);

-- Budget
insert into "budget" (user_uuid, name) values (
    (select uuid from "user" limit 1),
    'first_budget'
);

-- Categories
with c (
    budget_uuid
    ) as (
    values (
        (select uuid as budget_uuid from "budget" limit 1)
    )
)

insert into "category" (budget_uuid, name) values
    ((select budget_uuid from c limit 1), 'Food'),
    ((select budget_uuid from c limit 1), 'Transportation'),
    ((select budget_uuid from c limit 1), 'Housing'),
    ((select budget_uuid from c limit 1), 'Savings & Investments');

-- Entries
insert into "entry" (user_uuid, category_uuid, description, amount)
select
    (select uuid from "user" limit 1),
    uuid,
    name,
    random () * (100-1) + 3
from "category";