---ADD NEW COLUMN

SELECT *
FROM staging.preferred_roles;

ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

/*
---DROP COLUMN
ALTER TABLE staging.preferred_roles
DROP COLUMN preferred_role;
*/

---CHANGE TABLE NAME THEN QUERY TABLE
ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

SELECT *
FROM staging.priority_roles;

---RENAME COLUMN
ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

---CHANGE DATA_TYPE, SET DEFAULT VALUES, DROP DEFAULT VALUES, SET NOT NULL
ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;