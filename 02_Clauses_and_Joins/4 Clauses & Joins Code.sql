#1a
Select title, price From Books
Where author = "Arundhati Roy"
and publication_year > 2015;

#1b
Select title From Books
where genre In ("Fiction", "Philosophy")
And price Between 600 and 900;

#2a
Select region, sum(quantity) as Total_quantity From Sales
Group by region;

#2b
Select region, sum(amount) as Total_sales From Sales
Group by region
Having Total_sales > 50000;

#3a
Select Students.name, Results.subject, Result.marks From Students 
Join Results on Students.student_id = Results.student_id;

#3b
Select Students.name, Results.marks From Students
Left Join Results on Students.student_id = Results.student_id;

#4
Select
 Dev_team.dev_emp_name,
 Dev_team.dev_project_name,
 QA_team.qa_emp_name, 
 QA_team.qa_project_name 
 From Dev_Team
Left Join QA_team on Dev_team.dev_emp_name = QA_team.qa_emp_name

Union

Select
 Dev_team.dev_emp_name,
 Dev_team.dev_project_name,
 QA_team.qa_emp_name, 
 QA_team.qa_project_name 
 From Dev_Team
Right Join QA_team on Dev_team.dev_emp_name= QA_team.qa_emp_name;










   
     
     
 

      

     