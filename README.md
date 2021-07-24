# UrlShorten

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Application Requirements

When navigating to the root path (e.g. http://localhost:8080/) of the app in a browser a user should be presented with a form that allows them to paste in a (presumably long) URL (e.g. https://www.google.com/search?q=url+shortener&oq=google+u&aqs=chrome.0.69i59j69i60l3j0j69i57.1069j0j7&sourceid=chrome&ie=UTF-8).

When a user submits the form they should be presented with a simplified URL of the form http://localhost:8080/{slug} (e.g. http://localhost:8080/h40Xg2). The format and method of generation of the slug is up to your discretion.

When a user navigates to a shortened URL that they have been provided by the app (e.g. http://localhost:8080/h40Xg2) they should be redirected to the original URL that yielded that short URL (e.g https://www.google.com/search?q=url+shortener&oq=google+u&aqs=chrome.0.69i59j69i60l3j0j69i57.1069j0j7&sourceid=chrome&ie=UTF-8).

Only allow valid URLs (e.g., start with http(s)://{domain}/ )

# Deliverables

Implement your solution, including test cases for your application code.

We will execute your code using either:

(a) the make targets specified in Makefile (download this file). 
Edit the contents of Makefile to provide an interface for running and testing your application
Include any other notes for our engineering team that you would like regarding your approach, assumptions you have made, how to run your code, how to use your application, etc in a file named notes.txt.

(b) Or you could use other tools (like Docker/Docker-Compose, npm, or Yarn) to make it easy for the Evaluator to quickly and easily setup your submission, run the tests, and run the application. 

Please put your instructions in notes.txt how to setup, run, and test your application if you are not using the Makefile
