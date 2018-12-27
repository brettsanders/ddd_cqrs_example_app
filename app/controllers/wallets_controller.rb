class WalletsController < ApplicationController
  def index
    @wallets = WalletsReadModel::Wallet.all
  end

  def show
    @wallet = WalletsReadModel::Wallet.find_by(uid: params[:id])
  end

  def new
    @wallet_id  = SecureRandom.uuid
  end

  def create
    cmd = Wallets::CreateNewWallet.new(wallet_id: params[:wallet_id])
    command_bus.(cmd)

    new_wallet = WalletsReadModel::Wallet.find_by_uid(cmd.wallet_id)
    if new_wallet
      redirect_to wallet_path(new_wallet.uid), notice: 'New Wallet Created'
    else
      flash[:error] = "Unable to create new wallet"
      redirect_to new_wallet_path
    end
  end

  def add_money
    cmd = Wallets::AddMoneyToWallet.new(
      wallet_id: params[:id],
      amount: params[:amount_to_add])
    command_bus.(cmd)

    redirect_to wallet_path(params[:id])
  end

  def history
    wallet_uid = params[:id]
    stream_name = "Wallets::Wallet$#{wallet_uid}"
    @event_history = event_store.read.backward.stream(stream_name).from(:head).to_a
  end
end
