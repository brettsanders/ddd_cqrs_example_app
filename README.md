Todos:
- Add CreateWallet Command
- Add RemoveMoney Command
- Add UI to Manage Wallet
    Create and Add/Remove Money from the Wallet

Add Login to the App
- Scope the Wallets to the Logged In User
- How handle notion of Logged in w/ this system?
    ie. has_many / belongs_to and scoping

Scope Orders to Logged In User
Use Wallet to fund the Order
- Question: How use 2 Bounded Contexts Together?
  Orders & Wallets
  Money from Wallet is required to be used w/ the Order


Notes:
run single test w/ mini-test
`rake test TEST=wallets/test/add_money_to_wallet_test.rb`

creating event
`Rails.configuration.event_store.publish(InvoicePrinted.new(data: {invoice_number: 'FV-1/12/18'}))`

reading events
`Rails.configuration.event_store.read.to_a`

view events in "event browser"
`visit localhost:3003/res`


# cqrs-es-sample-with-res

CQRS with Event Sourcing sample app using [Rails Event Store](https://railseventstore.org). See it [live](https://cqrs-es-sample-with-res.herokuapp.com/).

[![Build Status](https://travis-ci.com/RailsEventStore/cqrs-es-sample-with-res.svg?branch=master)](https://travis-ci.com/RailsEventStore/cqrs-es-sample-with-res)
[![Maintainability](https://api.codeclimate.com/v1/badges/c444add86606b981e1fb/maintainability)](https://codeclimate.com/github/RailsEventStore/cqrs-es-sample-with-res/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/c444add86606b981e1fb/test_coverage)](https://codeclimate.com/github/RailsEventStore/cqrs-es-sample-with-res/test_coverage)


[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)