# Simple-Library

A Library management system for students to borrow books.

### CSC-517: Object Oriented Design and Development: Team - t123
<hr>

## This document explains all the functionalities with the workflow. 

### You can access our web portal using the application URL given below (hosted on HEROKU)

##### https://simplelibrary007.herokuapp.com

  
##### Admin details:
  - Admin : admin@simple-lib.com
  - Pass  : admin1
  
  - Login and Click on top-right button (displaying Admin name) to edit admin name

### Web Application can be viewed in 3 roles:
1. Admin
2. Student
3. Librarian

#### Register / Login
- To login with Google Auth, you first need to sign up with the same email id. 
- Click on signup and Register as Librarian or Student
- Librarian must be approved by admin and must select a library
- Student must select Education level and University

### Admin:

1. Web Application is preconfigured with an admin account. The admin credentials are provided above.
2. Admin can login via email and password from the signin page.
3. After logging in, admin can perform the following operations from the homepage:
	
	**View Libraries** - All the libraries avaliable in the system
  
	**Add New Library** - Add a new library in the system
	
	**View Books** - View all books available in the system
	
	**Add New Book**- Add a new book in the system - same book cannot be added twice, use Update Book count feature to change number of books at particular library
	
	**Add Book to Library** - Add a book in library with correspondin count
	
	**View Librarians to Approve** - View list of new librarians to approve
	
	**Update book count** - Navigate to View Libraries -> View Books -> Edit Count. Change the count from the form displayed
	
4.	Admin can also edit his profile but will not be able to delete the account.
5.	Admin can logout using Logout option given in top-right corner.

<hr>

### Librarian:

1.	After signing up, the Library can associate himself with a Library by editing the profile information. He can choose any existing company in the system or create a new company in the edit profile page.
2.	After login, Librarian can perform the following operations from the homepage:
	- Librarian will be able to view all the books.
  	- Librarian can add existing books (added by admin) to his library.
  	- Librarian can approve or deny requests special books.
  	- Librarian can view hold requests on books by students. 

<hr>

### Student:

1. 	A Student can login using his/her email id and password.
2.	After login, Student can perform the following operations from the homepage:


	**Search Books** - Student can filter books according to the filters he/she will set.
	
	**View Libraries** - All libraries associated with student's university will be displayed. Students can check all books in a library which they can checkout or hold.
	
	**View Book Requests** - History of all book requests made by the student.

	**View Bookmarks** - View all bookmarked books
	

3. 	**Checkout book:** 
	- Click on "View Libraries" to see list of all libraries associated with student's university.
	- Click on "View Books" to see all available books in the library
	- Click on "Show Book" to see details of the book
	- Click "Checkout" to checkout a book, return deadline will be displayed
		- If no books are availabe "Hold" option is displayed
		- If book is marked special - request is raised for librarian to approve
		- On approval book is added to user's checked out books
	- The book will appear in "View Book Requests" option on student's home
	
	- <b>Special book</b>: if book is marked special, a request will be raised to the librarian of the university; on approval of which, the book will get added to user's checked out list.
4.	Students can view status of the books checked out/ hold/ returned in "View Book Requests"		
5.	Students can edit profile using the button given on top right corner.
6.	They can also delete their profile.

<hr>

##### Run project in local:
Ensure Ruby and Rails are installed in system
  ```bash
  git clone Repo_URL
  cd simple-library
  bundle install
  rake db:migrate
  rails s
  ```
