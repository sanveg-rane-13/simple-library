# Simple-Library

A Library management system for students to borrow books.

### CSC-517: Team - t123
<hr>

## This document explains all the functionalities with the workflow. 

### You can access our web portal using the application URL given below (hosted on HEROKU)

##### https://simplelibrary007.herokuapp.com

  
##### Admin details:
  - Admin : admin@simple-lib.com
  - Pass  : admin1
  
 ##### Run project in local:
  - Clone the repo
  - cd into simple-library
  - run command - bundle install
  - run command - rake db:migrate
  - run command - rails s

### Web Application can be viewed in 3 roles:
1. Admin
2. Student
3. Librarian


### Admin:

1. Web Application is preconfigured with an admin account. The admin credentials are provided above.
2. Admin can login via email and password from the signin page.
3. After logging in, admin can perform the following operations from the homepage:
	
**List All Libraries** - All the libraries avaliable in the DB. Admin can add/delete them.
  
**List All Books** - All the Books avaliable in the DB. Admin can add/delete them.
	
	**List All Librarians** - All the Librarians listed on the portal will be displayed with the relevant details. The Admin will approve a librarian file.
	
	**List All Students**- All the users registered on the portal will be displayed.The Admin can view/modify/delete the Students.
	
	**Add New Library** - Admin can create a new Library.
	
4.	Admin can also edit his profile but will not be able to delete the account.
5.	Admin can logout using Logout option given in top-right corner.



### Librarian:

1.	After signing up, the Library can associate himself with a Library by editing the profile information. He can choose any existing company in the system or create a new company in the edit profile page.
2.	After login, Librarian can perform the following operations from the homepage:

	**Books** - Librarian will be able to view all the books.
  - Librarian can add books with relevant information to the library.
  - Librarian can approve special books.
  - Librarian can view overdue fines on students for books.
  - Librarian can view hold requests on books by students. 



### Student:

1. 	A Student can login using his/her email id and password.
2.	After login, Student can perform the following operations from the homepage:
	
	**View Libraries** - All the libraries present in the DB will be viewed.
	
	**Manage Borrowed Books** - Student can manage it's books.
	
	**Search Books** - Student can filter books according to the filters he/she will set.

3.	Student can edit profile using the button given on top right corner.
4.	They can also delete their profile whenever they want.
