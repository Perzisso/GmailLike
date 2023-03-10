class EmailsController < ApplicationController
  before_action :set_email, only: %i[ show edit update destroy ]

  # GET /emails or /emails.json
  def index
    @emails = Email.order(created_at: :desc)
  end

  # GET /emails/1 or /emails/1.json
  def show
    #@email=Email.find(params:[id])
  end

  # GET /emails/new
  def new
    @email = Email.new
  end

  # GET /emails/1/edit
  def edit
  end

  # POST /emails or /emails.json
  def create
    @email = Email.create(object: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)

    render turbo_stream: [
      turbo_stream.prepend('email_new',
                          partial: 'email',
                          locals: {email: @email})
      ]
  end


  # PATCH/PUT /emails/1 or /emails/1.json
  def update
  end

  # DELETE /emails/1 or /emails/1.json
  def destroy

    @email.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Email was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:object, :body)
    end
end
