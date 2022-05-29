--Deliverable 1: The Number of Retiring Employees by Title
SELECT e.emp_no, e.first_name, e.last_name,t.title, t.from_date, t.to_date
INTO retirement_titles	   
FROM employees e 
INNER JOIN  titles t ON (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
order by e.emp_no

SELECT count(*) FROM public.retirement_titles
--Total number of retirement titles: 133776

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date='9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT count(*) FROM public.unique_titles
--Total number of unique_titles:72458

-- Retrieve the number of employees by their most recent job title who are about to retire.
SELECT count(*) as count, title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(*) DESC;

SELECT * FROM public.retiring_titles


--Deliverable 2: The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (t.emp_no) t.emp_no, e.first_name, e.last_name, e.birth_date,de.from_date, de.to_date, t.title
INTO mentorship_eligibilty
FROM employees e 
INNER JOIN dept_emp de ON (e.emp_no = de.emp_no)
INNER JOIN titles t ON (e.emp_no = t.emp_no)
WHERE de.to_date='9999-01-01' 
AND t.to_date='9999-01-01' 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY t.emp_no;

SELECT *
FROM public.mentorship_eligibilty

SELECT count(*) 
FROM public.mentorship_eligibilty