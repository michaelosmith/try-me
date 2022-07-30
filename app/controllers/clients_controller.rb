class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /clients
  def index
    @pagy, @clients = pagy(Client.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @clients
  end

  # GET /clients/1 or /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new

    # Uncomment to authorize with Pundit
    # authorize @client
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients or /clients.json
  def create
    @client = Client.new(client_params)

    # Uncomment to authorize with Pundit
    # authorize @client

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: "Client was successfully created." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: "Client was successfully updated." }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: "Client was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @client
  rescue ActiveRecord::RecordNotFound
    redirect_to clients_path
  end

  # Only allow a list of trusted parameters through.
  def client_params
    params.require(:client).permit(:mindbody_id, :first_name, :last_name, :email, :photo, :gender, :date_of_birth, :member, :mindbody_profile_created, :mindbody_profile_updated, :account_id)

    # Uncomment to use Pundit permitted attributes
    # params.require(:client).permit(policy(@client).permitted_attributes)
  end
end
