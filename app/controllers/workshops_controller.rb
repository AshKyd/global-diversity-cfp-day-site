class WorkshopsController < ApplicationController
  before_action :set_workshop, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    if current_workshop.present?
      redirect_to workshop_path(current_workshop)
    end

    @workshop = Workshop.new
  end

  def edit
  end

  def create
    if current_workshop.present?
      redirect_to workshop_path(current_workshop)
    end

    @workshop = Workshop.new(workshop_params)
    current_user.workshop = @workshop

    respond_to do |format|
      if @current_user.save
        format.html do
          redirect_to @workshop, notice: 'Workshop was successfully created.'
          AdminMailer.workshop_created(@workshop, current_user).deliver
        end
        format.json { render :show, status: :created, location: @workshop }
      else
        format.html { render :new }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @workshop.update(workshop_params)
        format.html do
          redirect_to @workshop, notice: 'Workshop was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @workshop }
      else
        format.html do
          flash[:alert] = 'Workshop failed to updated.'
          render :edit
        end
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @workshop.destroy
    respond_to do |format|
      format.html { redirect_to workshops_url, notice: 'Workshop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_workshop
    @workshop = current_workshop
  end

  def workshop_params
    params.require(:workshop).permit(:continent,
    :country,
    :city,
    :venue_address,
    :google_maps_url,
    :start_time,
    :end_time,
    :time_zone,
    :ticketing_url,
    :organiser_id,
    :facilitator_id,
    :notes,
    :access_information_prodivded,
    :public_transport_near_venue,
    :public_transport_accessible_mobility_devices,
    :public_transport_accessible_service_animals,
    :public_transport_accessible_sight_impaired,
    :area_around_venue_safe,
    :how_far_parking,
    :cost_of_parking,
    :parking_well_lit,
    :parking_gated,
    :parking_gaurded,
    :venue_security,
    :venue_access_process,
    :steps,
    :ramps_or_elevators,
    :elevators_buttons,
    :childcare_nearby,
    :quiet_room,
    :nursing_room_for_new_mothers,
    :safe_for_small_children,
    :navigable_by_disabled,
    :chairs_arms,
    :drinks_allowed,
    :number_of_bathrooms,
    :number_of_handicap_stalls,
    :number_of_gender_neutral_stalls,
    :public_transport_near_venue_notes,
    :public_transport_accessible_mobility_devices_notes,
    :public_transport_accessible_service_animals_notes,
    :public_transport_accessible_sight_impaired_notes,
    :area_around_venue_safe_notes,
    :parking_well_lit_notes,
    :parking_gated_notes,
    :parking_gaurded_notes,
    :venue_security_notes,
    :quiet_room_notes,
    :nursing_room_for_new_mothers_notes,
    :safe_for_small_children_notes,
    :navigable_by_disabled_notes,
    :chairs_arms_notes,
    :drinks_allowed_notes)
  end
end
