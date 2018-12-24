require 'rails_event_store'
require 'aggregate_root'
require 'arkency/command_bus'


Rails.configuration.to_prepare do
  Rails.configuration.event_store = RailsEventStore::Client.new
  Rails.configuration.command_bus = Arkency::CommandBus.new

  AggregateRoot.configure do |config|
    config.default_event_store = Rails.configuration.event_store
  end

  # Note: Subscriptions are to Past Tense
  #   - They occur after the Command has been handled
  Rails.configuration.event_store.tap do |store|
    # Orders (Subscriptions)
    store.subscribe(Orders::OnOrderSubmitted, to: [Ordering::OrderSubmitted])
    store.subscribe(Orders::OnOrderExpired, to: [Ordering::OrderExpired])
    store.subscribe(Orders::OnOrderPaid, to: [Ordering::OrderPaid])
    store.subscribe(Orders::OnItemAddedToBasket, to: [Ordering::ItemAddedToBasket])
    store.subscribe(Orders::OnItemRemovedFromBasket, to: [Ordering::ItemRemovedFromBasket])

    # Payment (Subscriptions)
    # Payment is subscribed to multiple events
    store.subscribe(PaymentProcess, to: [
      Ordering::OrderSubmitted,
      Ordering::OrderExpired,
      Ordering::OrderPaid,
      Payments::PaymentAuthorized,
      Payments::PaymentReleased,
    ])

    # Wallets (Subscriptions)
    store.subscribe(WalletsReadModel::OnMoneyAddedToWallet, to: [Wallets::MoneyAddedToWallet])
  end

  # Note: Commands are Present Tense
  Rails.configuration.command_bus.tap do |bus|
    # Ordering (Commands)
    bus.register(Ordering::SubmitOrder, Ordering::OnSubmitOrder.new(number_generator: Rails.configuration.number_generator))
    bus.register(Ordering::SetOrderAsExpired, Ordering::OnSetOrderAsExpired.new)
    bus.register(Ordering::MarkOrderAsPaid, Ordering::OnMarkOrderAsPaid.new)
    bus.register(Ordering::AddItemToBasket, Ordering::OnAddItemToBasket.new)
    bus.register(Ordering::RemoveItemFromBasket, Ordering::OnRemoveItemFromBasket.new)

    # Payments (Commands)
    bus.register(Payments::AuthorizePayment, Payments::OnAuthorizePayment.new)
    bus.register(Payments::CapturePayment, Payments::OnCapturePayment.new)
    bus.register(Payments::ReleasePayment, Payments::OnReleasePayment.new)

    # Wallets (Commands)
    bus.register(Wallets::AddMoneyToWallet, Wallets::OnAddMoneyToWallet.new)
  end
end
