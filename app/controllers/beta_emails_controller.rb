class BetaEmailsController < ApplicationController
  # GET /beta_emails
  # GET /beta_emails.json
  def index
    @beta_emails = BetaEmail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beta_emails }
    end
  end

  # GET /beta_emails/1
  # GET /beta_emails/1.json
  def show
    @beta_email = BetaEmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beta_email }
    end
  end

  # GET /beta_emails/new
  # GET /beta_emails/new.json
  def new
    @beta_email = BetaEmail.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beta_email }
    end
  end

  # GET /beta_emails/1/edit
  def edit
    @beta_email = BetaEmail.find(params[:id])
  end

  # POST /beta_emails
  # POST /beta_emails.json
  def create
    @beta_email = BetaEmail.new(params[:beta_email])
    if @beta_email.save
      render 'create', :layout => false
    end
  end

  # PUT /beta_emails/1
  # PUT /beta_emails/1.json
  def update
    @beta_email = BetaEmail.find(params[:id])

    respond_to do |format|
      if @beta_email.update_attributes(params[:beta_email])
        format.html { redirect_to @beta_email, notice: 'Beta email was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beta_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beta_emails/1
  # DELETE /beta_emails/1.json
  def destroy
    @beta_email = BetaEmail.find(params[:id])
    @beta_email.destroy

    respond_to do |format|
      format.html { redirect_to beta_emails_url }
      format.json { head :no_content }
    end
  end
end
