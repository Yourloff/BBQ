class PhotosController < ApplicationController
  before_action :authenticate_user!, on: [:create]

  before_action :set_event, only: [:create, :destroy]
  before_action :set_photo, only: [:destroy]

  def create
    @new_photo = @event.photos.build(photo_params)
    authorize @new_photo

    @new_photo.user = current_user

    if @new_photo.save
      notify_photos(@event, @new_photo)

      redirect_to @event, notice: I18n.t('controllers.photos.created')
    else
      render 'events/show', alert: I18n.t('controllers.photos.error')
    end
  end

  def destroy
    authorize @photo

    message = { notice: I18n.t('controllers.photos.destroyed') }

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      # Если нет — сообщаем ему
      message = { alert: I18n.t('controllers.photos.error') }
    end

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_photo
    @photo = @event.photos.find(params[:id])
  end

  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end

  def notify_photos(event, photo)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [photo.user.email]).uniq

    all_emails.each do |mail|
      EventMailer.photo(event, photo, mail).deliver_now
    end
  end
end
