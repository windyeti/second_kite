class TypeEquipmentsController < ApplicationController
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

  def show
    @type_equipment = TypeEquipment.find(params[:id])
  end

  def index
    @type_equipments = TypeEquipment.all
  end

  private

  def type_equipment_params
    params.require(:type_equipment).permit(:name)
  end
end
