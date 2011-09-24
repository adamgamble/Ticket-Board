class TicketsController < ApplicationController
  before_filter :load_ticket, :only => [:advance_state, :reverse_state]
  private
  def load_ticket
    @ticket = Ticket.find params[:ticket_id]
  end

  public
  def advance_state
    @ticket.advance_state!
    render :nothing => true
  end

  def reverse_state
    @ticket.reverse_state!
    render :nothing => true
  end
end
