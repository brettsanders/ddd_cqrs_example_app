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
      redirect_to wallet_path(new_wallet), notice: 'New Wallet Created'
    else
      flash[:error] = "Unable to create new wallet"
      redirect_to new_wallet_path
    end
  end
end
