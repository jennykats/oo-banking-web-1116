class Transfer
  attr_accessor :sender, :receiver, :amount
  attr_reader :status
  def initialize (sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
    # @transfer_amount = transfer_amount
  end


  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && sender.balance > amount && self.status == 'pending'
      receiver.deposit(amount)
      sender.balance -= amount
      @status = 'complete'
    else
      @status = 'rejected'
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if valid? && receiver.balance > amount && @status == "complete"
      receiver.balance -= amount
      sender.balance += amount
      @status = "reversed"
    else
      @status = 'rejected'
    end
  end

end
