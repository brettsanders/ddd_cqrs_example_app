class WalletsController < ApplicationController
  def index
    @wallets = WalletsReadModel::Wallet.all
  end

  def show
    @wallet = WalletsReadModel::Wallet.find_by(uid: params[:id])
  end

  def new
    @order_id  = SecureRandom.uuid
    @products  = Product.all
    @customers = Customer.all
  end

  def create
    cmd = Wallets::CreateNewWallet.new(wallet_id: params[:wallet_id])
    command_bus.(cmd)
    redirect_to wallet_path(Wallets::Wallet.find_by_uid(cmd.wallet_id)), notice: 'New Wallet Created'
  end
end
