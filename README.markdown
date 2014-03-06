Static Site Contact Form
========================

Basically, what it says on the tin. I've got a statically generated site, but I
also want a contact form on it, so what's a person to do? Well, one option is
to post the form to a small non-static site to deliver the form submission by
email. This app will do that.

How it Works
------------

Once deployed, point a form on your static site to the address you've deployed
this app. Any form data submitted to this app will be emailed to the email
address you configure. The person submitting the form will get redirected back
to your site (where exactly they end up after submitting will be configurable).

```html
<!-- put a form like this on your site -->
<form method="post" action="http://contact.example.com">
  <label for="name">Name</label>
  <input type="text" name="name" id="name">

  <label for="body">Message</label>
  <textarea name="body" id="body"></textarea>

  <input type="submit" value="Send">
</form>
```

Deploying
---------

Built to be deployed to Heroku, and the documentation that follows reflects
this, but you can do whatever you want.

Configuring
-----------

### Delivery

You **must** configure a delivery mechanism. Current supported options are
Heroku's built-in Sendgrid add-on or your own SMTP server.

#### SMTP (Preferred)

Set the `DELIVERY_SERVER` environment variable with a valid SMTP URI:

```
heroku config:set DELIVERY_SERVER=smtp://username:password@example.com
```

#### Sendgrid (Alternate)

If you don't have an SMTP server to use, you can spin up a free Sendgrid
account (for low volumes) with Heroku. Heroku will provide the correct
environment variables for this app to deliver through Sendgrid

```
heroku addons:add sendgrid:starter
```

Once you've completed this, log into Heroku's web interface and click into the
Sendgrid add-on, since there's few steps they ask you to complete (making
choices on some settings, and so on) before delivering email.

### Recipient

You **must** configure a recipient email address with the RECIPIENT environment
variable.

```
heroku config:set RECIPIENT=hello@example.com
```

### Sender

You can optionally specify the email address that these emails come from with the SENDER environment variable. If not configured, defaults to the recipient email address.

```
heroku config:set SENDER=no-reply@example.com
```

### Redirect

You can optionally specify a URL (thank-you page, perhaps) to redirect the
visitor back to once the email is delivered. If you don't specify this, they'll
get redirected back to the page they came from.

```
heroku config:set REDIRECT=http://example.com/thankyou
```


TODOs
-----

* Robust test suite
* JS endpoint to return some JSON upon success, to be handled by the sending page?
* Some type of CSRF protection?
