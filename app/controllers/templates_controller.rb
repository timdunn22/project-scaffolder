class TemplatesController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    templates = Template.public_templates.or(Template.where(user: current_user)).order(created_at: :desc)
    render json: templates.map { |t| template_json(t) }
  end

  def show
    template = Template.find(params[:id])
    render json: template_json(template, full: true)
  end

  def create
    template = current_user.templates.new(template_params)
    if template.save
      render json: template_json(template), status: :created
    else
      render json: { errors: template.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    template = current_user.templates.find(params[:id])
    template.destroy
    head :no_content
  end

  private

  def template_params
    params.permit(:name, :description, :is_public, file_structure: {})
  end

  def template_json(t, full: false)
    json = { id: t.id, name: t.name, description: t.description, is_public: t.is_public, created_at: t.created_at }
    json[:file_structure] = t.file_structure if full
    json
  end
end
