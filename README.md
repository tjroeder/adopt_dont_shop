# Adopt, don't Shop Project: Turing 2110 BE Mod 2

![languages](https://img.shields.io/github/languages/top/tjroeder/relational_rails?color=red)
[![Ruby](https://github.com/tjroeder/relational_rails/actions/workflows/tests.yml/badge.svg)](https://github.com/tjroeder/relational_rails/actions/workflows/tests.yml)
![PRs](https://img.shields.io/github/issues-pr-closed/tjroeder/relational_rails)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov) <!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/contributors-1-orange.svg?style=flat)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

## About
- Project requirements can be found [Here](https://github.com/turingschool-examples/adopt_dont_shop)
- Adopt, Don't Shop is a project designed for students to explore the use of Many-to-Many relationships in databases, CRUD, RESTful design principles, MVC, Heroku, and GitHub Project and to continue to familiarize ourselves with the conventions of a Rails framework by developing a navigable web app.

### Initial database design
![visual-schema.png](https://i.postimg.cc/0ywZgQ1W/visual-schema.png)

### New database design
![image](https://user-images.githubusercontent.com/78194232/146226315-6f5eeb81-790f-413c-994c-e7b940af8072.png)

## Requirements and Setup for Mac:

### Ruby and Rails
- Ruby Version 2.7.2
- Rails Version 5.2.6

### Gems
- RSpec, Pry, SimpleCov, Capybara, Launchy, Shoulda-Matchers v5.0, Orderly

### Local Setup
1. Clone this repository:
On your local machine open a terminal session and enter the following commands for SSH or HTTPS to clone the repositiory.


- using ssh key <br>
`$ git clone git@github.com:tjroeder/adopt_dont_shop.git`

- using https <br>
`$ git clone https://github.com/tjroeder/adopt_dont_shop.git`

Once cloned, you'll have a new local copy in the directory you ran the clone command in.

2. Change to the project directory:<br>
In terminal, use `$cd` to navigate to the Adopt, Don't Shop project directory.

`$ cd adopt_dont_shop`

3. Install required Gems utilizing Bundler: <br>
In terminal, use Bundler to install any missing Gems. If Bundler is not installed, first run the following command.

`$ gem install bundler`

If Bundler is already installed or after it has been installed, run the following command.

`$ bundle install`

There should be be verbose text diplayed of the installation process that looks similar to below. (this is not an actual copy of what will be output).

```
$ bundle install
Fetching gem metadata from https://rubygems.org/........
Resolving dependencies...
Using bundler 2.1.4
Using byebug 11.1.3
Fetching coderay 1.1.2
Installing coderay 1.1.2
Using diff-lcs 1.4.4
Using method_source 1.0.0
Using pry 0.13.1
Fetching pry-byebug 3.9.0
Installing pry-byebug 3.9.0
Fetching rspec-support 3.10.1
Installing rspec-support 3.10.1
Fetching rspec-core 3.10.1
Installing rspec-core 3.10.1
Fetching rspec-expectations 3.10.1
Installing rspec-expectations 3.10.1
Fetching rspec-mocks 3.10.1
Installing rspec-mocks 3.10.1
Fetching rspec 3.10.0
Installing rspec 3.10.0
Bundle complete! 3 Gemfile dependencies, 12 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```
If there are any errors, verify that bundler, Rails, and your ruby environment are correctly setup.

4. Database Migration<br>
Before using the web application you will need to setup your databases locally by running the following command

`$ rails db:{:drop,:create,:migrate,:seed}`

5. Startup and Access<br>
Finally, in order to use the web app you will have to start the server locally and access the app through a web browser. 
- Start server
`$rails s`

- Open web browser and visit link
    http://localhost:3000/
    
At this point you should be taken to the welcome page of the web-app. If you encounter any errors or have not reached the web-app please confirm you followed the steps above and that your environment is properly set up.

## Heroku Deployment
- The deployment to Heroku can be found [here](https://infinite-depths-31715.herokuapp.com/).

## Contributor ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/tjroeder"><img src="https://avatars.githubusercontent.com/u/78194232?v=4" width="100px;" alt=""/><br /><sub><b>Tim (he/him)</b></sub></a><br /><a href="https://github.com/tjroeder/relational_rails/commits?author=tjroeder" title="Code">💻</a> <a href="#ideas-tjroeder" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/tjroeder/relational_rails/commits?author=tjroeder" title="Tests">⚠️</a> <a href="https://github.com/tjroeder/relational_rails/pulls?q=is%3Apr+reviewed-by%3Atjroeder" title="Reviewed Pull Requests">👀</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.
<!-- -->

# Project Requirements
## Learning Goals

In this project, students will build upon the code in this repo to create a Pet Adoption Platform. Users will be able to apply to adopt pets, and Admins will be able to approve or reject applications and see statistics for the Shelters, Pets, and Applications in the system.

* Build out CRUD functionality for a many to many relationship
* Use ActiveRecord to write queries that join multiple tables of data together
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Validate models and handle sad paths for invalid data input
* Use flash messages to give feedback to the user
* Use partials in views
* Use `within` blocks in tests
* Track user stories using GitHub Projects
* Deploy an application to Heroku

## Check In

During your Check In, you should be prepared to review your database schema for the many to many relationship, your deployment to Heroku, and your GitHub Projects board.

## Rubric

| | **Feature Completeness** | **Rails** | **ActiveRecord** | **Testing and Debugging** | **Project Management** |
| --- | --- | --- | --- | --- | --- |
| **4: Exceptional**  | All User Stories 100% complete including all sad paths and edge cases, and some extension work completed | Students implement strategies not discussed in class and can defend their design decisions | At least one ActiveRecord extension is complete | 100% coverage for features and models. A gem that enhances testing effectiveness is implemented (orderly, factorybot, faker, etc). Students can point to multiple examples of edge case testing that are not included in the user stories | GitHub Project board is fully up to date in all checkins and the evaluation. Students create custom cards on the project board to track tasks in addition to user stories.
| **3: Passing** | All stories in the "Deploy", "Apply for Pet(s)", "Database Logic Part 1", and "Approving Applications" sections are completed | Students use the principles of MVC to effectively organize code with only 1 - 2 infractions. Action View helpers are used to create forms, links, and buttons. Routes and Actions mostly follow RESTful conventions, and student can defend any non restful routes. At least one partial is created and included in at least two different views. Models include validations. Flash messages are used. | ActiveRecord helpers are utilized whenever possible. ActiveRecord is used in a clear and effective way to read/write data. No Ruby is used to process data. All queries functional and accurately implemented. | 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. Tests utilize within blocks to target specific areas of a page | Student uses GitHub Project to track all user stories. Project board is mostly up to date in all checkins. Project board is fully up to date at the evaluation |
| **2: Below Expectations** | All stories in the "Deploy", "Apply for Pet(s)", and "Database Logic Part 1" sections are completed |  Students use the principles of MVC to effectively organize code, but may have more than 2 infractions. Some routes and actions are not restful, and student cannot defend those decisions. Project may fail to include one of the following: a partial that is included in at least two different views, model validations, or use of flash messages. | Ruby is used to process data that could use ActiveRecord instead. Some instances where ActiveRecord helpers are not utilized. Some queries not accurately implemented. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective, or tests do not utilize within blocks | GitHub Project board is not utilized during one of the checkins. Project board is not fully up to date during evaluation.
| **1: Failing** | Students fail to complete "Database Logic Part 1" section | Project fails to include two out of the following: a partial that is included in at least two different views, model validations, or use of flash messages | Ruby is used to process data more often than ActiveRecord. Many cases where ActiveRecord helpers are not utilized. | Below 90% coverage for either features or models. | GitHub projects is not utilized

## Evaluation

Before your evaluation, choose 2 user stories to present. Try to pick user stories that you think will deliever the highest value in terms of feedback from the instructor. 

During the evaluation, you will present your user story:

* Demonstrate the user story on Heroku (or localhost if the feature is not functional in Production)
* Show the test(s) for the user story
* Show all code that implements the user story

# User Stories

## Deploy

- [x] done
```
Deploy your application to Heroku

As a visitor of the site
I will perform all user stories
By visiting the application on Heroku.
Localhost is fine for development, but
the application must be hosted on Heroku.

Use these guides: https://devcenter.heroku.com/articles/getting-started-with-rails5
```

## Apply for Pet(s)

Visitors to the site will be able to create applications to adopt pets. An application has many pets. Pets can have many applications.

- [x] done
```
Application Show Page

As a visitor
When I visit an applications show page
Then I can see the following:
- Name of the Applicant
- Full Address of the Applicant including street address, city, state, and zip code
- Description of why the applicant says they'd be a good home for this pet(s)
- names of all pets that this application is for (all names of pets should be links to their show page)
- The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
```

- [x] done
```
Starting an Application

As a visitor
When I visit the pet index page
Then I see a link to "Start an Application"
When I click this link
Then I am taken to the new application page where I see a form
When I fill in this form with my:
  - Name
  - Street Address
  - City
  - State
  - Zip Code
And I click submit
Then I am taken to the new application's show page
And I see my Name, address information, and description of why I would make a good home
And I see an indicator that this application is "In Progress"
```

- [x] done
```
Starting an Application, Form not Completed

As a visitor
When I visit the new application page
And I fail to fill in any of the form fields
And I click submit
Then I am taken back to the new applications page
And I see a message that I must fill in those fields.
```

- [x] done
```
Searching for Pets for an Application

As a visitor
When I visit an application's show page
And that application has not been submitted,
Then I see a section on the page to "Add a Pet to this Application"
In that section I see an input where I can search for Pets by name
When I fill in this field with a Pet's name
And I click submit,
Then I am taken back to the application show page
And under the search bar I see any Pet whose name matches my search
```

- [x] done
```
Add a Pet to an Application

As a visitor
When I visit an application's show page
And I search for a Pet by name
And I see the names Pets that match my search
Then next to each Pet's name I see a button to "Adopt this Pet"
When I click one of these buttons
Then I am taken back to the application show page
And I see the Pet I want to adopt listed on this application
```

- [x] done
```
Submit an Application

As a visitor
When I visit an application's show page
And I have added one or more pets to the application
Then I see a section to submit my application
And in that section I see an input to enter why I would make a good owner for these pet(s)
When I fill in that input
And I click a button to submit this application
Then I am taken back to the application's show page
And I see an indicator that the application is "Pending"
And I see all the pets that I want to adopt
And I do not see a section to add more pets to this application
```

- [x] done
```
No Pets on an Application

As a visitor
When I visit an application's show page
And I have not added any pets to the application
Then I do not see a section to submit my application
```

## Database Logic Part 1

These stories emphasize key database concepts

- [x] done
```
Partial Matches for Pet Names

As a visitor
When I visit an application show page
And I search for Pets by name
Then I see any pet whose name PARTIALLY matches my search
For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"
```

- [x] done
```
Case Insensitive Matches for Pet Names

As a visitor
When I visit an application show page
And I search for Pets by name
Then my search is case insensitive
For example, if I search for "fluff", my search would match pets with names "Fluffy", "FLUFF", and "Mr. FlUfF"
```

- [x] done
```
SQL Only Story

For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql

Admin Shelters Index

As a visitor
When I visit the admin shelter index ('/admin/shelters')
Then I see all Shelters in the system listed in reverse alphabetical order by name
```

- [x] done
```
For this story, you should fully leverage ActiveRecord methods in your query.

Shelters with Pending Applications

As a visitor
When I visit the admin shelter index ('/admin/shelters')
Then I see a section for "Shelter's with Pending Applications"
And in this section I see the name of every shelter that has a pending application
```

## Approving Applications

Pets on an application can either be accepted or rejected.

For this set of stories, we will be making routes that begin with '/admin'. This is to indicate that only a user with special privileges should be able to accept or reject pets on an application. Normally, we would want to make sure that a user is logged into an admin account before being able complete any of this workflow, but we will not add any log in or authorization functionality to this project.
- [x] done
```
Approving a Pet for Adoption

As a visitor
When I visit an admin application show page ('/admin/applications/:id')
For every pet that the application is for, I see a button to approve the application for that specific pet
When I click that button
Then I'm taken back to the admin application show page
And next to the pet that I approved, I do not see a button to approve this pet
And instead I see an indicator next to the pet that they have been approved
```

- [x] done
```
Rejecting a Pet for Adoption

As a visitor
When I visit an admin application show page ('/admin/applications/:id')
For every pet that the application is for, I see a button to reject the application for that specific pet
When I click that button
Then I'm taken back to the admin application show page
And next to the pet that I rejected, I do not see a button to approve or reject this pet
And instead I see an indicator next to the pet that they have been rejected
```

- [x] done
```
Approved/Rejected Pets on one Application do not affect other Applications

As a visitor
When there are two applications in the system for the same pet
When I visit the admin application show page for one of the applications
And I approve or reject the pet for that application
When I visit the other application's admin show page
Then I do not see that the pet has been accepted or rejected for that application
And instead I see buttons to approve or reject the pet for this specific application
```

## Completed Applications

Once all pets on an application have been marked either accepted or rejected, then the application is no longer "Pending". If all the pets were accepted, then the application is "Accepted". If one or more pets on the application is rejected, then the entire application is "Rejected".

- [x] done
```
All Pets Accepted on an Application

As a visitor
When I visit an admin application show page
And I approve all pets for an application
Then I am taken back to the admin application show page
And I see the application's status has changed to "Approved"
```

- [x] done
```
One or More Pets Rejected on an Application

As a visitor
When I visit an admin application show page
And I reject one or more pets for the application
And I approve all other pets on the application
Then I am taken back to the admin application show page
And I see the application's status has changed to "Rejected"
```

```
Application Approval makes Pets not adoptable

As a visitor
When I visit an admin application show page
And I approve all pets on the application
And when I visit the show pages for those pets
Then I see that those pets are no longer "adoptable"
```

```
Pets can only have one approved application on them at any time

[ ] done

As a visitor
When a pet has an "Approved" application on them
And when the pet has a "Pending" application on them
And I visit the admin application show page for the pending application
Then next to the pet I do not see a button to approve them
And instead I see a message that this pet has been approved for adoption
And I do see a button to reject them
```

## Database Logic Part 2

These stories emphasize SQL and ActiveRecord concepts.

```
SQL Only Story

For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql

Admin Shelters Show Page

As a visitor
When I visit an admin shelter show page
Then I see that shelter's name and full address

NOTE: Your query should only return the necessary data to complete the story
```

### ActiveRecord

For the following stories, you should fully leverage ActiveRecord methods in your queries.

```
Shelters with Pending Applications Listed Alphabetically

As a visitor
When I visit the admin shelter index ('/admin/shelters')
And I look in the section for shelters with pending applications
Then I see all those shelters are listed alphabetically
```

```
Admin Shelters Show Page Links

As a visitor
When I visit the admin shelter index ('/admin/shelters')
Then I see that every shelter name is a link
When I click one of these links
Then I am taken to that shelter's admin show page
```

```
Average Pet Age

As a visitor
When I visit an admin shelter show page
Then I see a section for statistics
And in that section I see the average age of all adoptable pets for that shelter
```

```
Count of Adoptable Pets

As a visitor
When I visit an admin shelter show page
Then I see a section for statistics
And in that section I see the number of pets at that shelter that are adoptable
```

```
Count of Pets that have been Adopted

As a visitor
When I visit an admin shelter show page
Then I see a section for statistics
And in that section I see the number of pets that have been adopted from that shelter

Note: A Pet has been adopted from a shelter if they are part of an approved application
```

```
Action Required

As a visitor
When I visit an admin shelter show page
Then I see a section titled "Action Required"
In that section, I see a list of all pets for this shelter that have a pending application and have not yet been marked "approved" or "rejected"
```

```
Action Required Links to Application Show Page

As a visitor
When I visit an admin shelter show page
And I look in the "Action Required" section
Then next to each pet's name I see a link to the admin application show page where I can accept or reject the pet.
```

## Extensions

### ActiveRecord Extensions

1. Refactor your code to make use of [ActiveRecord callbacks](https://guides.rubyonrails.org/active_record_callbacks.html)
1. Refactor your code to make use of [ActiveRecord Scopes](https://guides.rubyonrails.org/active_record_querying.html#scopes)

### Styling

Implement a CSS Grid Framework to improve your styling, either [CSS Grid Layout](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout) or [Bootstrap](https://getbootstrap.com/)
