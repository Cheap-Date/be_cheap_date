# Cheap Date Overview
Cheap Date is an easy and fun application for planning dates on a budget. Users can discover low-cost (and free) events in their area, and add these events to a date. Dates are then stored in the user history for easy repeat use.

Cheap Date utilizes service-oriented architecture (SOA), and is divided into the following two repositories:
  - [Cheap Date Front End](https://github.com/Cheap-Date/cheap_date_fe)
  - [Cheap Date Back End](https://github.com/Cheap-Date/be_cheap_date) (you are here)

Each repository's services are compartmentalized so that updates and service interruptions to the front end do not disrupt the back end's operations, and vice versa.

# Getting Started with Cheap Date

To begin your Cheap Date journey, you'll need the following prerequisites:
- Ruby Version x.x.x
- A terminal application, such as Terminal (MacOS) or [Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal/) (Windows)
- A code editor, such as [VSCode](https://code.visualstudio.com/)

Once you've installed these prerequisites, you can begin installing Cheap Date.

## Step One: Install the Cheap Date Front End 

1. Clone down the [Cheap Date front end.](https://github.com/Cheap-Date/cheap_date_fe)
2. Open the front end repo within VSCode (or your preferred code editor).
3. Open a terminal session within the front end repo, and run the command `bundle install`
4. In the same terminal session, run `rails db:{drop,create}`
5. In the same terminal session, run `rails dev:cache`
6. Finally, in the same terminal session, run `rails server`

## Step Two: Install the Cheap Date Back End 

1. Clone down the [Cheap Date back end.](https://github.com/Cheap-Date/be_cheap_date)
2. Open the back end repo within VSCode (or your preferred code editor).
3. Open a terminal session within the back end repo, and run the command `bundle install`
4. In the same terminal session, run `rails db:{drop,create,migrate}`
5. In the same terminal session, run `rails dev:cache`
6. In the same terminal session, run `rails server`

## Step Three: Access Cheap Date in your browser

Now that the servers are running for both the front end and the back end servers, you can begin using Cheap Date by visiting `localhost:5000` in your browser.

_(Note that the Cheap Date front end is configured to use port 5000 by default, while the backend is configured to use 3000 by default. If these ports are already occupied on your machine, you can edit the port configurations in each repo's copy of `/config/puma.rb'._

# Credits, Licensing, and Acknowledgments

## Gems and Other Technologies

- [Yelp Fusion API](https://docs.developer.yelp.com/docs/fusion-intro)
- [Ruby on Rails](https://rubyonrails.org/)
- [Bootstrap](https://github.com/twbs/bootstrap-rubygem)
- [Devise](https://github.com/heartcombo/devise)
- [Faraday](https://github.com/lostisland/faraday)
- [Capybara](https://github.com/teamcapybara/capybara)
- [WebMock](https://github.com/bblimke/webmock)
- [VCR](https://github.com/vcr/vcr)

<img src="https://mikewilliamson.files.wordpress.com/2010/05/rails_on_ruby.jpg" alt="drawing" width="75"/>
<img src="https://codekitapp.com/images/help/free-bootstrap-icon@2x.png" alt="drawing" width="75"/>

## How to Contribute 

Contributions are welcome! Please feel free to submit a pull request with any contributions, and a member of the team will review it ASAP. You can also contact us using the links below. 

## Authors

  - **Nathan Lambertson** - *[LinkedIn](https://www.linkedin.com/in/nathan-lambertson/), [GitHub](https://github.com/lambo1986)* 
  - **Miranda Delaney** - *[LinkedIn](https://www.linkedin.com/in/mld52/), [GitHub](https://github.com/delaneymiranda1)* 
  - **Scott DeVoss** - *[LinkedIn](https://www.linkedin.com/in/scott-devoss/), [GitHub](https://github.com/scottdevoss)* 
  - **Matt Darlington** - *[LinkedIn](https://www.linkedin.com/in/matthew-darlington/), [GitHub](https://github.com/mdarl17)* 
  - **Dylan Perry** - *[LinkedIn](https://www.linkedin.com/in/dylanperry/), [GitHub](https://github.com/Dylan-Perry)* 

## License 

This project is not licensed and is open source. 

## Acknowledgments 
  - Project concept by Nathan Lambertson
  - Technical direction, consultation, and moral support by [Jamison Ordway](https://github.com/jamisonordway) and [Chris Simmons](https://github.com/cjsim89)
  - This project completed by Mod 3 students at [Turing School of Software and Design](https://turing.edu/)
