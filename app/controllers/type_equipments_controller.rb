class TypeEquipmentsController < ApplicationController
  before_action :load_type_equipment, only: [:show, :edit, :update]

  authorize_resource

  def new
    @type_equipment = TypeEquipment.new
  end

  def create
    @type_equipment = TypeEquipment.new(type_equipment_params)
    if @type_equipment.save
      redirect_to @type_equipment
    else
      render :new
    end
  end

  def show; end

  def index
    @type_equipments = TypeEquipment.all
  end

  def edit; end

  def update
    if @type_equipment.update(type_equipment_params)
      redirect_to @type_equipment
    else
      render :edit
    end
  end

  private

  def type_equipment_params
    params.require(:type_equipment).permit(:name)
  end

  def load_type_equipment
    @type_equipment = TypeEquipment.find(params[:id])
  end
end
