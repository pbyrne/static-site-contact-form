Static Site Contact Form
========================

Basically, what it says on the tin. I've got a staticly generated site, but I
also want a contact form on it, so what's a person to do? Well, one option is
to post the form to a small non-static site to deliver the form submission by
email.

How it Works
------------

Once deployed, point a form on your static site to the address you've deployed
this app. Any form data submitted to this app will be emailed to the email
address you configure. The person submitting the form will get redirected back
to your site (where exactly they end up after submitting will be configurable).

Deploying
---------

Meant to be deployed to Heroku, but you can do whatever you want. Walkthrough TBD.

Configuring
-----------

Spitballing here, but it's what I've got so far:

* The email addres(s) to deliver form submissions to
* The domain(s) from which form submissions should be accepted
* The URL to redirect the user back to (some kind of "thanks for contacting
  me!" page is what I figure this should be)
