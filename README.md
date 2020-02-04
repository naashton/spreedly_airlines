# Spreedly Airlines

Welcome to Spreedly Airlines. Spreedly Airlines is built with Rails!

### Dependencies
Rails 6.0.2.1<br>
ruby 2.5.7p206

### Getting Started
* Clone the repository to your local machine
* `bundle`
* `db:migrate`
* `db:seed`
* `rails s`
Default execution will setup `localhost:3000`.

##### Setup Spreedly Environment Credentials - Security
In order to setup the credentials, navigate to the Spreedly ID site and grab the credentials for the <b>Spreedly Airlines - The Nick Division</b>. 

* `rails credentials:edit`

If you've never done this before, rails will let you know that you need to setup an editor and will tell you the command to run in order to do so. It is likely simplest to use vim (assuming you know the basics) or some other command line editor. 

Once you're in, just follow the template for the existing entry (which should be an aws entry) for credentials.

This neat little tool will store your credentials in an encrypted file that is added to `.gitignore` by default. 

If you use another version control software (like VCS) make sure you add that `Master.key` to your ignore file so that you do not commit it and put it out in the wild. Even though it is encrypted, encryption is not full proof.

### About Us
We are a very small startup in our infancy. You should not use this app to book real flights for real holidays. 

You should use this app to learn about Spreedly's payment processing API. This app has implemented the basic verify, gateways, payment method, purchase API calls, as well as additional entry points, like receivers, in order to utilize `Payment Method Distribution` to use Spreedly as a proxy to process payments through 3rd party API's.

For more information, e-mail the developer at `nick@spreedly.com`.