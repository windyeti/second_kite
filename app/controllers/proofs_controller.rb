class ProofsController < ApplicationController
  authorize_resource :class => false

  def index
    @proofs = Ad.where(approve: false)
  end

  def show
    @proof = Ad.find(params[:id])
  end

  def update
    @proof = klass.find(params[:id])

    respond_to do |format|
      if @proof.update(approve: true)
        format.json { render json: { proof: { proof: @proof, klass: klass.to_s } } }
      else
        format.json { render json: { errors: @proof.errors.full_messages }, status: 422 }
      end
    end
  end

  def notification
    @proof = Ad.find(params[:id])
    args = {
            ad: @proof,
            link_ad: url_for(@proof),
            subject: params[:subject],
            message: params[:message]
            }
    DismissUserBrandJob.perform_later(args)
    redirect_to proofs_path
  end

  private

  def klass
    params[:klass].constantize
  end

  def proofs_params
    params.permit(:subject, :message)
  end
end
