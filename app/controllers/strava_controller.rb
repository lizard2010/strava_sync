class StravaController < ApplicationController
  before_action :set_strava, only: %i[show edit update destroy]

  def index
    strava_default
  end

  # GET /strava/code
  def code
    strava = Strava.new(strava_code_params)
    response = JSON.parse strava.get_authorization_token, symbolize_names: true
    redirect_to('/', notice: strava.error_catch(response)) if strava.error_catch(response)

    return unless response[:athlete].present?

    strava = strava.save_athlete(response[:athlete])
    strava.update(response.slice(*Strava::STRAVA_TOKENS))
    strava.save!
    redirect_to strava, notice: 'Strava Athlete was successfully added/updated.'
  end

  # POST /stravas
  # POST /stravas.json
  def create
    @strava = Strava.new(strava_params)

    respond_to do |format|
      if @strava.save
        format.html { redirect_to @strava, notice: 'Strava was successfully created.' }
        format.json { render :show, status: :created, location: @strava }
      else
        format.html { render :new }
        format.json { render json: @strava.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stravas/1
  # PATCH/PUT /stravas/1.json
  def update
    respond_to do |format|
      if @strava.update(strava_params)
        format.html { redirect_to @strava, notice: 'Strava was successfully updated.' }
        format.json { render :show, status: :ok, location: @strava }
      else
        format.html { render :edit }
        format.json { render json: @strava.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stravas/1
  # DELETE /stravas/1.json
  def destroy
    @strava.destroy
    respond_to do |format|
      format.html { redirect_to stravas_url, notice: 'Strava was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_strava
    @strava = Strava.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def strava_params
    params.fetch(:strava, {})
  end

  def strava_code_params
    params.permit(Strava::STRAVA_CALL_CODE.map(&:to_sym))
  end

  def strava_default
    @strava_grant_request_url = Strava.grant_request_url
  end
end
