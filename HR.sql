show tables;

drop table hr;

# CREATING THE TABLE

create table hr(
Employee_ID varchar(100),
Full_Name char(100),
Department char(100),
Job_Title char(100),
Hire_Date date,
Location VARCHAR(100),
Performance_Rating int,
Experience_Years int,
Stats  char(100),
Work_Mode char(100),
Salary_INR  int
);

# LOADING THE DATASET

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data.csv'
INTO TABLE hr
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Employee_ID, Full_Name, Department, Job_Title, @Hire_Date, Location,
 Performance_Rating, Experience_Years, Stats, Work_Mode, Salary_INR)
SET Hire_Date = STR_TO_DATE(@Hire_Date, '%d-%m-%Y');

select count(*) from hr;
select * from hr;

# 1 EMPLOYEES BY DEPARTMENT
select Department, 
count(*) as Total
from hr
group by department;


# 2. EMPLOYEES BY JOB ROLE
select  Job_Title,
count(*) as Total
from hr
group by Job_Title;

# 3 AVERAGE SALARY IN A COMPANY
select round(avg(Salary_INR),2) as Average_Salary
from hr; 

# 4 AVERAGE SALARY BY DEPARTMENT
select Department,
round(avg(salary_inr),2) as Avg_salary
from hr
group by Department;

# 5 HIGHEST AND LOWEST SALARY OF EMPLOYEE 
select 
max(Salary_INR) as Highest_Salary,
min(Salary_INR) as lowest_Salary
from hr;

# 6 SALARY BY JOB ROLE
select 
Job_Title,
round(avg(salary_inr)) as Avg_salary
from hr
group by Job_Title;

# 7 EMPLOYEES BY WORK MODE
select 
work_mode, 
count(*) as Total
from hr 
group by
 work_mode;

 # 8 EMPLOYEES BY STATS
 select
 stats,
 count(*) as Total
from hr 
group by 
stats; 

# 9 SALARY BY YEARS OF EXPERIENCE
select Experience_Years,
round(avg(Salary_INR),2) as Avg_Salary
from hr
group by Experience_Years
order by avg_salary;
 
# 10 EXPERIENCE BY JOB ROLE
select Job_Title,
round(avg(Experience_Years),2) as Avg_Exp
from hr 
group by 
Job_Title;

# 11 AVERAGE PERFORMANCE OF EMPLOYEES
select
round(avg(Performance_Rating)) as Avg_Rating
from hr;

# 12 PERFORMANCE BY DEPARTMENT
select
Department,
round(avg(Performance_Rating),2) as Avg_Rating
from hr 
group by Department;

# 13 TOP 10 HIGHEST PAID EMPLOYEES
select 
Employee_ID,Full_Name,Department,Job_Title,Salary_INR
from hr
order by Salary_INR desc limit 10;

# 14 DEPARTMENTS WITH HIGHEST AVERAGE SALARIES
select
Department,
round(avg(Salary_INR)) as Avg_Salary
from hr
group by Department
order by Avg_Salary desc;

# 15 EMPLOYEES BY YEAR
select
year(Hire_Date) as Joined_year,
count(*) as Hired_Employees
from hr
group by year(Hire_Date)
order by Joined_year ;

# 16 COUNT OF EMPLOYEES WITH PERFORMANCE RATING >4
select 
count(*) as Rating
from hr
where Performance_Rating>=4;

# 17 EMPLOYEES COUNT BY EXPERIENCE CATEGORY
select
case 
when Experience_Years <=3 then'BEGINNER (0-3)' 
 when Experience_Years between 4 and 7 then 'SKILLED (4-7)'
 when Experience_Years between 8 and 12 then 'EXPERIENCED (8-12)'
 else 'PROFESSIONAL (>12)' 
 end as EXP_CATEGORY,
 count(*) as Total
 from hr
 group by EXP_CATEGORY
 order by EXP_CATEGORY ;
 
 # 18 SALARY DISTRIBUTION BY EMPLOYEES
 select 
 case
 when Salary_INR <=500000 then 'LOW'
 when Salary_INR between 500001 and 1000000 then 'MEDIUM'
 else 'HIGH'
 end as salary_category,
 count(*) as Total
 from hr
 group by salary_category;
 
 # 19 EMPLOYEES WITH LOW PERFORMANCE  AND LOW SALARY
 select 
 count(*) AS Risk_Employees
 from hr
 where Performance_Rating <=2
 and salary_inr < (select avg(salary_inr) from hr);
 
 # 20 EMPLOYEES WITH HIGH  PERFORMANCE  AND LOW SALARY
 select 
 count(*) AS Underpaid_Employees
 from hr
 where Performance_Rating >4
 and salary_inr < (select avg(salary_inr) from hr);
  
  select * from hr;

# 21 CALCULATING EMPLOYEES JOINED IN THE MONTH OF JULY & YEAR 2019
select 
count(*) as July_Hiries
from hr
where Month (Hire_Date)=7
and year(Hire_Date)=2019;

# 22 EMPLOYEES HIRED BY YEAR
select 
year(Hire_Date) as joined_year,
count(*) as Emp_by_year
from hr
group by year(Hire_Date)
order by year(hire_date);

# 23 EMPLOYEES BY MONTH
select 
month(Hire_Date)  as Num,
date_format(hire_date,'%M') as Joined_month,
count(*) as Emp_by_month
from hr
group by month(Hire_Date),joined_month
order by num;



