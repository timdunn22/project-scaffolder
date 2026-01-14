import { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { templates, projects } from '../api/client';
import Layout from '../components/Layout';

export default function Generate() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [template, setTemplate] = useState(null);
  const [projectName, setProjectName] = useState('my-project');
  const [loading, setLoading] = useState(true);
  const [generating, setGenerating] = useState(false);

  useEffect(() => { templates.get(id).then((r) => setTemplate(r.data)).finally(() => setLoading(false)); }, [id]);

  const handleGenerate = async () => {
    setGenerating(true);
    try {
      const response = await projects.generate(id, { project_name: projectName });
      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', `${projectName}.zip`);
      document.body.appendChild(link);
      link.click();
      link.remove();
    } catch (err) {
      alert('Generation failed: ' + (err.response?.data?.error || err.message));
    } finally {
      setGenerating(false);
    }
  };

  if (loading) return <Layout><div className="text-center py-8">Loading...</div></Layout>;
  if (!template) return <Layout><div className="text-center py-8 text-red-500">Template not found</div></Layout>;

  return (
    <Layout>
      <div className="max-w-2xl mx-auto space-y-6">
        <h1 className="text-2xl font-bold text-gray-900">Generate: {template.name}</h1>
        <p className="text-gray-600">{template.description}</p>

        <div className="bg-white p-6 rounded-lg shadow space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700">Project Name</label>
            <input type="text" value={projectName} onChange={(e) => setProjectName(e.target.value.replace(/\s/g, '-').toLowerCase())} className="mt-1 w-full px-3 py-2 border border-gray-300 rounded-md" />
          </div>

          <button onClick={handleGenerate} disabled={generating || !projectName} className="w-full py-3 px-4 bg-purple-600 text-white rounded-md hover:bg-purple-700 disabled:opacity-50">
            {generating ? 'Generating...' : 'Download Project ZIP'}
          </button>
        </div>

        <button onClick={() => navigate('/templates')} className="text-gray-500 hover:text-gray-700">&larr; Back to Templates</button>
      </div>
    </Layout>
  );
}
