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

### Web Application can be viewed in 3 roles:
1. Admin
2. Student
3. Librarian


### Admin:

1. Web Application is preconfigured with an admin account. The admin credentials are provided above.
2. Admin can login via email and password from the signin page.
3. After logging in, admin can perform the following operations from the homepage:
	
	**View Libraries** - All the libraries avaliable in the system
  
	**Add New Library** - Add a new library in the system
	
	**View Books** - View all books available in the system
	
	**Add New Book**- Add a new book in the system
	
	**Add Book to Library** - Add a book in library with correspondin count
	
	**View Librarians to Approve** - View list of new librarians to approve
	
4.	Admin can also edit his profile but will not be able to delete the account.
5.	Admin can logout using Logout option given in top-right corner.



### Librarian:

1.	After signing up, the Library can associate himself with a Library by editing the profile information. He can choose any existing company in the system or create a new company in the edit profile page.
2.	After login, Librarian can perform the following operations from the homepage:
	- Librarian will be able to view all the books.
  	- Librarian can add existing books (added by admin) to his library.
  	- Librarian can approve or deny requests special books.
  	- Librarian can view hold requests on books by students. 



### Student:

1. 	A Student can login using his/her email id and password.
2.	After login, Student can perform the following operations from the homepage:
	
	**View Libraries** - All the libraries present in the DB will be viewed.
	
	**Manage Borrowed Books** - Student can manage his books.
	
	**Search Books** - Student can filter books according to the filters he/she will set.
3. 	**Checkout book:** 
	- Click on "View Libraries" to see list of all libraries associated with student's university.
	- Click on "View Books" to see all available books in the library
	- Click on "Show Book" to see details of the book
	- Click "Checkout" to checkout a book, return deadline will be displayed
		- If no books are availabe "Hold" option is displayed
		- If book is marked special - request is raised for librarian to approve
		- On approval book is added to user's checked out books
	- The book will appear in "View Book Requests" option on student's home
4.	Students can view status of the books checked out/ hold/ returned in "View Book Requests"		
5.	Student can edit profile using the button given on top right corner.
6.	They can also delete their profile whenever they want.


 ##### Run project in local:
  - Clone the repo
  - cd into simple-library
  - run command - bundle install
  - run command - rake db:migrate
  - run command - rails s
