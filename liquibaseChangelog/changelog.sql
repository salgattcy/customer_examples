--liquibase formatted sql

--comment CYRAL_LABEL DBROLE_TESTING public role_testing name
--comment CYRAL_LABEL DOC_MASK_TEST public doctors country
--comment CYRAL_LABEL HASHTABLE_ID rewrite hashtable customer_id
--comment CYRAL_LABEL JSON_INFO testing orders info
--comment CYRAL_LABEL MY_ADDRESS public doctors address2
--comment CYRAL_LABEL MY_ADDRESS public patients address1
--comment CYRAL_LABEL MY_ADDRESS public patients address2
--comment CYRAL_LABEL MY_CCN public transactions credit_card_number
--comment CYRAL_LABEL MY_CCN schema table column2

--changeset scott.algatt:1
--rollback DROP TABLE person;
create table person (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)

--changeset scott.algatt:2
--rollback DROP TABLE company;
--comment CYRAL_LABEL ADDRESS public company address1
create table company (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)

--changeset other.dev:3
--rollback ALTER TABLE person DROP COLUMN country;
alter table person add column country varchar(2)

--changeset other.dev:4
--rollback ALTER TABLE person DROP COLUMN state;
alter table person add column state varchar(2)

--changeset other.dev:5
--rollback ALTER TABLE company DROP COLUMN country;
alter table company add column country varchar(2)

--comment CYRAL_LABEL MY_EMAIL schema table column
--comment CYRAL_LABEL MY_EMAIL schema2 table2 column3
--comment CYRAL_LABEL MY_SSN sensitive user_data user_data
--comment CYRAL_LABEL RDS_FIRST_NAME public actor first_name
--comment CYRAL_LABEL RDS_FIRST_NAME public customer first_name
--comment CYRAL_LABEL RDS_FIRST_NAME public staff first_name
--comment CYRAL_LABEL RDS_GENERIC_SBTEST public departments0 dept_name
--comment CYRAL_LABEL RDS_LAST_NAME public actor last_name
--comment CYRAL_LABEL RDS_LAST_NAME public customer last_name
--comment CYRAL_LABEL RDS_LAST_NAME public staff last_name
--comment CYRAL_LABEL RDS_MASK_EMAIL public customer email
--comment CYRAL_LABEL RDS_MASK_EMAIL public staff email
--comment CYRAL_LABEL RDS_MASK_PAYMENT public payment amount
--comment CYRAL_LABEL RDS_MASK_TEXT public file description
--comment CYRAL_LABEL TEST_CNID unknown schema column
--comment CYRAL_LABEL TEST_CNID userdata userinfo cn_card_id_num