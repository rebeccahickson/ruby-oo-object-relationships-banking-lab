require 'pry'

class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && @status == 'pending' && sender.balance >= amount
      @status = 'complete'
      receiver.deposit(amount)
      sender.withdrawal(amount)
    else
      @status = 'rejected'
      'Transaction rejected. Please check your account balance.'
    end
  end

  def reverse_transfer
    if @status == 'complete'
      receiver.withdrawal(amount)
      sender.deposit(amount)
      @status = 'reversed'
    end
  end
end
