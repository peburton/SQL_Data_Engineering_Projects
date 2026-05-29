
--USE this database
USE job_mart;

--CREATE TABLE IF IT DOES NOT EXIST ALREADY
CREATE TABLE IF NOT EXISTS staging.preferred_roles(
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR
);

--INSERT DATA INTO TABLE
INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES (1, 'Data Engineer'),
       (2, 'Senior Data Engineer'),
       (3, 'Software Engineer');

--CHECK DATA
SELECT *
FROM staging.preferred_roles;

--Update to indicate when the role is 'data engineer' or 'senior data engineer' that it is a preferred role
UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id = 1 OR role_id = 2;

--Update to indicate when the role is 'software engineer' that it is not a preferred role
UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

--Update priority_lvl to be 3 IF role is Software Engineer
UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;

--new table name query
SELECT *
FROM staging.priority_roles;