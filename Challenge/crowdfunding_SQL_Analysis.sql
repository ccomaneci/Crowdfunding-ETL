-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT cf_id, backers_count
FROM campaign
WHERE outcome = 'live'
ORDER BY backers_count DESC;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT cf_id, COUNT(backer_id) AS "Total Backers"
FROM backers
GROUP BY cf_id
ORDER BY "Total Backers" DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT CN.first_name, 
       CN.last_name, 
       CN.email, 
       (CP.goal-CP.pledged) AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM contacts as CN
JOIN campaign as CP
ON CP.contact_id = CN.contact_id
WHERE CP.outcome = 'live'
ORDER BY "Remaining Goal Amount" DESC;



-- Check the table
select * from email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

drop table email_backers_remaining_goal_amount

select b.email, b.first_name, b.last_name, c1.cf_id, c1.company_name, c1.description, c1.end_date, c1.goal - c1.pledged as left_of_goal
into email_backers_remaining_goal_amount
from backers as b
JOIN campaign AS cam ON cam.cf_id=b.cf_id
INNER JOIN contacts as con ON con.contact_id=cam.contact_id
ORDER BY b.last_name, b.first_name;


-- Check the table
select * from email_backers_remaining_goal_amount

