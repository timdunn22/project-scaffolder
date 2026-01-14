require 'zip'
require 'fileutils'

class ProjectGeneratorService
  def self.generate(template, config)
    new(template, config).generate
  end

  def initialize(template, config)
    @template = template
    @config = config
    @project_name = config[:project_name] || 'my-project'
  end

  def generate
    temp_dir = Rails.root.join('tmp', 'projects', SecureRandom.hex)
    project_dir = temp_dir.join(@project_name)
    FileUtils.mkdir_p(project_dir)

    create_files(project_dir, @template.file_structure)

    zip_path = temp_dir.join("#{@project_name}.zip")
    create_zip(project_dir, zip_path)

    zip_path.to_s
  end

  private

  def create_files(base_dir, structure, current_path = '')
    structure.each do |name, content|
      path = File.join(base_dir, current_path, name)

      if content.is_a?(Hash)
        FileUtils.mkdir_p(path)
        create_files(base_dir, content, File.join(current_path, name))
      else
        FileUtils.mkdir_p(File.dirname(path))
        File.write(path, process_template(content.to_s))
      end
    end
  end

  def process_template(content)
    content.gsub(/\{\{(\w+)\}\}/) { @config[$1.to_sym] || @config[$1] || '' }
  end

  def create_zip(source_dir, zip_path)
    Zip::File.open(zip_path, Zip::File::CREATE) do |zip|
      Dir.glob("#{source_dir}/**/*").each do |file|
        entry_name = file.sub("#{source_dir}/", '')
        if File.directory?(file)
          zip.mkdir(entry_name)
        else
          zip.add(entry_name, file)
        end
      end
    end
  end
end
