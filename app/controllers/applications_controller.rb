class ApplicationsController < ApplicationController
  before_action :require_authentication
  before_action :set_application, only: %i[ show edit update destroy ]

  # GET /applications or /applications.json
  def index
    @applications = Current.user.applications
  end

  # GET /applications/1 or /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = Application.new
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications or /applications.json
  def create
    @application = Current.user.applications.build(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to applications_path, notice: "Application was successfully created." }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1 or /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, notice: "Application was successfully updated." }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1 or /applications/1.json
  def destroy
    @application.destroy!

    respond_to do |format|
      format.html { redirect_to applications_path, status: :see_other, notice: "Application was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def application_params
      params.expect(application: [ :position, :company, :position_url, :description, :status ])
    end
end
