class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_event, only: %i[destroy edit show update]
  after_action :verify_authorized, only: %i[destroy edit show update]

  def index
    @events = Event.all

    authorize @events
  end

  def show
    pincode = params[:pincode] || cookies.permanent["events_#{@event.id}_pincode"]

    event_context = EventContext.new(event: @event, pincode: pincode)
    authorize event_context, policy_class: EventPolicy
    cookies.permanent["events_#{@event.id}_pincode"] = pincode

    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
  rescue Pundit::NotAuthorizedError
    render_require_pincode_form
  end

  def new
    @event = current_user.events.build

    authorize @event
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)

    authorize @event

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @event

    @event.destroy
    redirect_to events_path, notice: I18n.t('controllers.events.destroyed')
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description,
                                  :pincode)
  end

  def render_require_pincode_form
    flash.now[:alert] = I18n.t('controllers.events.wrong_pincode') if params[:pincode].present?
    render 'password_form'
  end
end
