class ProjectsController < ApplicationController
  def index
    projects = current_user.generated_projects.includes(:template).order(created_at: :desc)
    render json: projects.map { |p| { id: p.id, template_name: p.template.name, config_choices: p.config_choices, created_at: p.created_at } }
  end

  def generate
    template = Template.find(params[:template_id])
    config = params[:config] || {}

    project = current_user.generated_projects.create!(template: template, config_choices: config, download_count: 0)

    zip_path = ProjectGeneratorService.generate(template, config)

    send_file zip_path, filename: "#{config[:project_name] || 'project'}.zip", type: 'application/zip', disposition: 'attachment'
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Template not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
